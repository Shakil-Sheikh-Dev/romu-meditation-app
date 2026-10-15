import 'package:flutter/material.dart';
import 'package:romu/features/onboarding/models/onboarding_story.dart';
import 'package:romu/features/onboarding/views/onboarding_story_view.dart';
import 'package:romu/features/onboarding/widgets/onboarding_progress.dart';

class OnboardingFlowView extends StatefulWidget {
  const OnboardingFlowView({
    super.key,
    required this.stories,
    this.onBegin,
  });

  final List<OnboardingStory> stories;
  final VoidCallback? onBegin;

  @override
  State<OnboardingFlowView> createState() => _OnboardingFlowViewState();
}

class _OnboardingFlowViewState extends State<OnboardingFlowView> {
  late final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  double get _page {
    if (!_controller.hasClients) {
      return 0;
    }
    return _controller.page ?? _controller.initialPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.stories.length,
          itemBuilder: (context, index) {
            final isLast = index == widget.stories.length - 1;
            return OnboardingStoryView(
              story: widget.stories[index],
              onContinue: isLast ? widget.onBegin : () => _showPage(index + 1),
            );
          },
        ),
        Positioned(
          top: topInset + 46,
          left: 16,
          child: IgnorePointer(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return OnboardingProgress(
                  count: widget.stories.length,
                  page: _page,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
