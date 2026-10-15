import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/features/auth/widgets/auth_back_button.dart';

class MeditationDetailView extends StatelessWidget {
  const MeditationDetailView({
    super.key,
    this.title = 'Letting go of the day',
    this.narrator = 'Elena Rostova',
    this.minutes = 14,
    this.topic = 'Sleep',
  });

  final String title;
  final String narrator;
  final int minutes;
  final String topic;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 110 + bottomInset),
            children: [
              SizedBox(
                height: 360,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/meditation/hero.png'),
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0xFFF1EDE7)],
                          stops: [0.45, 1],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: AuthBackButton(onPressed: () => context.pop()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title,
                      variant: AppTextVariant.display,
                      color: AppColors.ink,
                      style: const TextStyle(fontSize: 40, height: 38 / 40),
                    ),
                    const SizedBox(height: 8),
                    AppText('Narrated by $narrator', variant: AppTextVariant.field, color: AppColors.muted),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: [
                        _Chip(label: topic, filled: true),
                        _Chip(label: '$minutes min'),
                        const _Chip(label: 'Guided'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.stroke),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'ABOUT THIS PRACTICE',
                            variant: AppTextVariant.caption,
                            style: TextStyle(letterSpacing: 1),
                          ),
                          SizedBox(height: 10),
                          AppText(
                            'Let the day slowly loosen its hold. This gentle meditation helps you release lingering thoughts, worries, and emotions from the day.\n\nThrough slow breathing and soothing guidance, you’ll quiet the mind, relax the body, and create space for stillness.',
                            variant: AppTextVariant.field,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const AppText(
                      'Best with headphones, somewhere quiet.',
                      variant: AppTextVariant.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + bottomInset,
            child: AppButton(
              label: 'Begin Session',
              backgroundColor: AppColors.ink,
              foregroundColor: AppColors.onImage,
              borderColor: Colors.transparent,
              leading: const Icon(Icons.play_arrow, color: AppColors.onImage),
              onPressed: () {
                context.push(
                  '/player?title=${Uri.encodeComponent(title)}&minutes=$minutes&subtitle=${Uri.encodeComponent(topic)}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFFD89A72) : AppColors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: filled ? const Color(0x80D89A72) : AppColors.stroke,
        ),
      ),
      child: AppText(
        label,
        variant: AppTextVariant.caption,
        color: filled ? AppColors.onImage : AppColors.muted,
      ),
    );
  }
}
