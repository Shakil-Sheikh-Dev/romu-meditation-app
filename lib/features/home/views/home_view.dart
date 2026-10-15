import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD89A72), Color(0x00F1EDE7)],
            stops: [0, 0.28],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  children: [
                    const AppText('Hello,', variant: AppTextVariant.fieldLabel),
                    const AppText(
                      'Natasha',
                      variant: AppTextVariant.headline,
                      color: AppColors.ink,
                      style: TextStyle(fontSize: 32, height: 34 / 32, letterSpacing: -0.4),
                    ),
                    const SizedBox(height: 20),
                    const AppText(
                      'Your day so far',
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    const SizedBox(height: 10),
                    const _StreakCard(),
                    const SizedBox(height: 24),
                    const AppText(
                      "Today's pick",
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    const SizedBox(height: 10),
                    _FeaturedCard(
                      onOpen: () => context.push(
                        '/meditation?title=${Uri.encodeComponent('Letting go of the day')}&minutes=14&topic=${Uri.encodeComponent('Sleep')}',
                      ),
                    ),
                    const SizedBox(height: 24),
                    const AppText(
                      'How are you feeling?',
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    const SizedBox(height: 10),
                    const _FeelingRow(),
                    const SizedBox(height: 24),
                    const AppText(
                      'Recommended for you',
                      variant: AppTextVariant.link,
                      color: AppColors.muted,
                    ),
                    const SizedBox(height: 10),
                    const _Recommendations(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: const AppNavBar(current: '/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.onImage,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.stroke),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('5 days in a row', variant: AppTextVariant.fieldLabel),
                SizedBox(height: 2),
                AppText('Gently does it.', variant: AppTextVariant.caption),
              ],
            ),
          ),
          Icon(Icons.local_fire_department, color: Color(0xFFE07A3D)),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 223,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Image(
                image: AssetImage('assets/images/home/featured.png'),
                fit: BoxFit.cover,
              ),
              const ColoredBox(color: Color(0x4D000000)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Coming back to yourself',
                                variant: AppTextVariant.headline,
                                style: TextStyle(fontSize: 30, height: 28 / 30),
                              ),
                              SizedBox(height: 6),
                              AppText(
                                'Meditation · 14 min',
                                variant: AppTextVariant.caption,
                                color: AppColors.onImage,
                              ),
                            ],
                          ),
                        ),
                        _PlayButton(onPressed: onOpen),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/images/home/play.svg'),
      ),
    );
  }
}

class _FeelingRow extends StatelessWidget {
  const _FeelingRow();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FeelingChip(label: 'Calm down', id: 'calm', color: Color(0xFFDCE9E4)),
          SizedBox(width: 8),
          _FeelingChip(label: 'Overthinking', id: 'overthinking', color: Color(0xFFF6E2D6)),
          SizedBox(width: 8),
          _FeelingChip(label: 'For sleep', id: 'sleep', color: Color(0xFFEBE8E3)),
          SizedBox(width: 8),
          _FeelingChip(label: 'For mornings', id: 'mornings', color: Color(0xFFF7E9C8)),
        ],
      ),
    );
  }
}

class _FeelingChip extends StatelessWidget {
  const _FeelingChip({
    required this.label,
    required this.id,
    required this.color,
  });

  final String label;
  final String id;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/category/$id'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AppText(label, variant: AppTextVariant.caption, color: AppColors.ink),
      ),
    );
  }
}

class _Recommendations extends StatelessWidget {
  const _Recommendations();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _SessionCard(
            image: 'assets/images/home/steady.png',
            title: 'Steady Mind',
            detail: 'Stress · 10 min',
            minutes: 10,
          ),
          SizedBox(width: 6),
          _SessionCard(
            image: 'assets/images/home/morning.png',
            title: 'Morning Clam',
            detail: 'Anxiety · 10 min',
            minutes: 10,
          ),
          SizedBox(width: 6),
          _SessionCard(
            image: 'assets/images/home/sleep.png',
            title: 'Deep Sleep',
            detail: 'Sleep',
            minutes: 12,
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.image,
    required this.title,
    required this.detail,
    required this.minutes,
  });

  final String image;
  final String title;
  final String detail;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/player?title=${Uri.encodeComponent(title)}&minutes=$minutes',
      ),
      child: SizedBox(
        width: 195,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: AssetImage(image),
                height: 158,
                width: 195,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            AppText(title, variant: AppTextVariant.fieldLabel),
            const SizedBox(height: 4),
            AppText(
              detail,
              variant: AppTextVariant.caption,
              color: const Color(0xFF98A2AE),
            ),
          ],
        ),
      ),
    );
  }
}
