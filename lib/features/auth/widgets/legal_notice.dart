import 'package:flutter/material.dart';
import 'package:romu/core/widgets/app_text.dart';
import 'package:romu/l10n/app_localizations.dart';

void showLegalNotice(BuildContext context, String title) {
  final l10n = AppLocalizations.of(context);
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: AppText(title, variant: AppTextVariant.fieldLabel),
        content: AppText(l10n.legalBody, variant: AppTextVariant.field),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(l10n.legalClose, variant: AppTextVariant.fieldLabel),
          ),
        ],
      );
    },
  );
}
