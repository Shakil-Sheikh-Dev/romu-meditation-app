import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_background.dart';
import 'package:romu/core/widgets/app_nav_bar.dart';
import 'package:romu/core/widgets/app_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: AppBackground(
        child: Positioned.fill(
            child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText('Hello,', variant: AppTextVariant.fieldLabel),
                              AppText(
                                'Natasha',
                                variant: AppTextVariant.headline,
                                color: AppColors.ink,
                                style: TextStyle(fontSize: 32, height: 34 / 32, letterSpacing: -0.4),
                              ),
                            ],
                          ),
                        ),
                        _NotificationButton(),
                      ],
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
                      color: Color(0xFF6E675F),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.2),
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
              const AppNavBar(current: '/home'),
            ],
          ),
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
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('5 days in a row', variant: AppTextVariant.fieldLabel),
                SizedBox(height: 2),
                AppText('Gently does it.', variant: AppTextVariant.caption),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/images/home/streak_fire.svg',
            width: 16,
            height: 24,
            fit: BoxFit.contain,
          ),
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

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/notifications'),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF33302C),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/home/notification_bell.svg',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
            ),
            const Positioned(
              top: 1,
              right: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFD93F3F),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(width: 8, height: 8),
              ),
            ),
          ],
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeelingTopic(
            label: 'Calm down',
            id: 'calm',
            icon: 'assets/images/home/feeling_calm.svg',
          ),
          SizedBox(width: 8),
          _FeelingTopic(
            label: 'Overthinking',
            id: 'overthinking',
            icon: 'assets/images/home/feeling_overthinking.svg',
          ),
          SizedBox(width: 8),
          _FeelingTopic(
            label: 'For sleep',
            id: 'sleep',
            icon: 'assets/images/home/feeling_sleep.svg',
          ),
          SizedBox(width: 8),
          _FeelingTopic(
            label: 'For mornings',
            id: 'mornings',
            icon: 'assets/images/home/feeling_mornings.svg',
          ),
        ],
      ),
    );
  }
}

class _FeelingTopic extends StatelessWidget {
  const _FeelingTopic({
    required this.label,
    required this.id,
    required this.icon,
  });

  final String label;
  final String id;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/category/$id'),
      child: SizedBox(
        width: 96,
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFAF8F5),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(icon, width: 30, height: 30, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            AppText(
              label,
              variant: AppTextVariant.caption,
              color: const Color(0xFF6E675F),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
