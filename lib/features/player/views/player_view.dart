import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/favorites/viewmodels/favorites_view_model.dart';

class PlayerView extends ConsumerStatefulWidget {
  const PlayerView({
    super.key,
    required this.title,
    required this.minutes,
    this.subtitle = 'Meditation',
  });

  final String title;
  final int minutes;
  final String subtitle;

  @override
  ConsumerState<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends ConsumerState<PlayerView>
    with SingleTickerProviderStateMixin {
  static const _track = 'assets/audio/romu_sample_song.mp3';

  late final AnimationController _glow = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );
  final AudioPlayer _audio = AudioPlayer(handleInterruptions: false);
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _stateSub;
  Duration _position = Duration.zero;
  Duration? _duration;
  var _playing = false;
  var _openedComplete = false;

  Duration get _total => _duration ?? Duration(minutes: widget.minutes);

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    _positionSub = _audio.positionStream.listen((position) {
      if (!mounted) {
        return;
      }
      setState(() => _position = position);
    });
    _stateSub = _audio.playerStateStream.listen((state) {
      if (!mounted) {
        return;
      }
      final completed = state.processingState == ProcessingState.completed;
      final playing = state.playing && !completed;
      setState(() => _playing = playing);
      if (completed) {
        _glow.stop();
        _openComplete();
        return;
      }
      if (playing) {
        if (!_glow.isAnimating) {
          _glow.repeat(reverse: true);
        }
      } else {
        _glow.stop();
      }
    });

    try {
      final file = await _copyTrack();
      final duration = await _audio.setFilePath(file.path);
      await _audio.setVolume(1);
      if (!mounted) {
        return;
      }
      setState(() => _duration = duration);
      await _audio.play();
    } catch (error, stackTrace) {
      debugPrint('Unable to play $_track: $error\n$stackTrace');
      if (mounted) {
        _glow.stop();
      }
    }
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _stateSub?.cancel();
    _audio.dispose();
    _glow.dispose();
    super.dispose();
  }

  void _openComplete() {
    if (_openedComplete || !mounted) {
      return;
    }
    _openedComplete = true;
    final title = Uri.encodeComponent(widget.title);
    final subtitle = Uri.encodeComponent(widget.subtitle);
    context.push(
      '/session-complete?title=$title&minutes=${widget.minutes}&subtitle=$subtitle',
    );
  }

  Future<File> _copyTrack() async {
    final data = await rootBundle.load(_track);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/romu_sample_song.mp3');
    final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    if (!file.existsSync() || file.lengthSync() != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return file;
  }

  Future<void> _setPlaying(bool value) async {
    if (value) {
      if (_audio.processingState == ProcessingState.completed) {
        await _audio.seek(Duration.zero);
      }
      await _audio.play();
    } else {
      await _audio.pause();
    }
  }

  Future<void> _seek(int seconds) async {
    final next = _position + Duration(seconds: seconds);
    final total = _total;
    final target = next.isNegative
        ? Duration.zero
        : next > total
        ? total
        : next;
    await _audio.seek(target);
  }

  String _clock(Duration value) {
    final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final saved = ref.watch(favoritesProvider);
    final favorite = saved.any((item) => item.title == widget.title);
    final progress = _total.inMilliseconds == 0
        ? 0.0
        : _position.inMilliseconds / _total.inMilliseconds;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D3CC),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF3EFEA), Color(0xFFB7B1AA), Color(0xFF8E8882)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.ink),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggle(
                            SavedPractice(
                              title: widget.title,
                              detail: '${widget.minutes} min',
                              kind: 'meditation',
                              minutes: widget.minutes,
                            ),
                          );
                        },
                        icon: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    widget.title,
                    variant: AppTextVariant.display,
                    color: AppColors.ink,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40, height: 36 / 40),
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    '${widget.subtitle}·${widget.minutes} min',
                    variant: AppTextVariant.caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  _PlayingGlow(animation: _glow, playing: _playing),
                  const Spacer(),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: const Color(0x66FFFFFF),
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      value: progress.clamp(0, 1),
                      onChanged: (value) {
                        final total = _total;
                        _audio.seek(
                          Duration(
                            milliseconds: (total.inMilliseconds * value).round(),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(_clock(_position), variant: AppTextVariant.caption, color: Colors.white),
                      AppText(_clock(_total), variant: AppTextVariant.caption, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SeekButton(label: '10S', icon: Icons.replay_10, onPressed: () => _seek(-10)),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () => _setPlaying(!_playing),
                        child: Container(
                          width: 87,
                          height: 87,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            _playing ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      _SeekButton(label: '10S', icon: Icons.forward_10, onPressed: () => _seek(10)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayingGlow extends StatelessWidget {
  const _PlayingGlow({required this.animation, required this.playing});

  final Animation<double> animation;
  final bool playing;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = playing ? animation.value : 0.35;
        final scale = 0.82 + (t * 0.36);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.lerp(const Color(0xFFFFC48A), const Color(0xFFFF8A3D), t)!,
                  const Color(0x66FFB074),
                  const Color(0x00FFB074),
                ],
                stops: const [0.18, 0.45, 1],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SeekButton extends StatelessWidget {
  const _SeekButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          AppText(label, variant: AppTextVariant.caption, color: Colors.white),
        ],
      ),
    );
  }
}
