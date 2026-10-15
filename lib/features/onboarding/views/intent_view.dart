import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/core/widgets/app_text_button.dart';
import 'package:romu/features/onboarding/models/intent_option.dart';
import 'package:romu/features/onboarding/viewmodels/intent_view_model.dart';
import 'package:romu/features/onboarding/widgets/intent_card.dart';
import 'package:romu/l10n/app_localizations.dart';

class IntentView extends ConsumerWidget {
  const IntentView({super.key, this.onBrowse});

  final VoidCallback? onBrowse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final options = IntentOption.options(l10n);
    final selectedId = ref.watch(intentViewModelProvider);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/intent_background.png'),
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 46, 16, 28 + bottomInset),
                child: Column(
                  children: [
                    AppText(
                      l10n.intentTitle,
                      variant: AppTextVariant.headline,
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var row = 0; row < options.length; row += 2) ...[
                              if (row > 0) const SizedBox(height: 15),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _card(ref, options[row], selectedId),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _card(
                                        ref,
                                        options[row + 1],
                                        selectedId,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextButton(
                      label: l10n.intentBrowse,
                      variant: AppTextVariant.link,
                      onPressed: onBrowse ?? () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(WidgetRef ref, IntentOption option, String? selectedId) {
    return IntentCard(
      iconAsset: option.iconAsset,
      title: option.title,
      subtitle: option.subtitle,
      selected: selectedId == option.id,
      onTap: () {
        ref.read(intentViewModelProvider.notifier).select(option.id);
        onBrowse?.call();
      },
    );
  }
}
