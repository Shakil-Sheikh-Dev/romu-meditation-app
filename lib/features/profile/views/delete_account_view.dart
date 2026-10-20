import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/l10n/app_localizations.dart';

void showDeleteAccountSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: const Color(0x851F1C1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) => const DeleteAccountSheet(),
  );
}

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0x851F1C1A),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: DeleteAccountSheet(),
      ),
    );
  }
}

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({super.key});

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  bool get _ready => _confirm.text.trim() == 'DELETE';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    final systemBar = keyboard > 0 ? 0.0 : media.padding.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: media.size.height * 0.92),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(24, 12, 24, 16 + systemBar),
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDD6CC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/images/profile/delete_badge.svg',
                width: 56,
                height: 56,
              ),
            ),
            SizedBox(height: 18),
            Text(
              l10n.deleteTitle,
              style: TextStyle(
                fontFamily: 'Cormorant Garamond',
                fontSize: 30,
                fontWeight: FontWeight.w500,
                height: 38 / 30,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.deleteBody,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 23 / 15,
                color: Color(0xFF6E675F),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: Color(0xFFFDFCFA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFDDD6CC)),
              ),
              child: Column(
                children: [
                  _EraseLine(l10n.deleteItem1),
                  SizedBox(height: 10),
                  _EraseLine(l10n.deleteItem2),
                  SizedBox(height: 10),
                  _EraseLine(l10n.deleteItem3),
                  SizedBox(height: 10),
                  _EraseLine(l10n.deleteItem4),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF1DE),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEEDDBA)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/profile/billing_info.svg',
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.deleteBilling,
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 19 / 13,
                        color: Color(0xFF94662A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Text(
              l10n.deleteType,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirm,
              onChanged: (_) => setState(() {}),
              cursorColor: AppColors.ink,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.ink,
              ),
              decoration: InputDecoration(
                hintText: 'DELETE',
                hintStyle: const TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9A938A),
                ),
                filled: true,
                fillColor: const Color(0xFFF7F4EF),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                border: _fieldBorder,
                enabledBorder: _fieldBorder,
                focusedBorder: _fieldBorder,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: const Color(0xFFFDFCFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Color(0xFFDDD6CC)),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(
                            l10n.deleteCancel,
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Material(
                    color: Color(0xFFC4554B),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: _ready ? () => context.go('/') : null,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(
                            l10n.profileDelete,
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFAF8F5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final _fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xFFDDD6CC)),
);

class _EraseLine extends StatelessWidget {
  const _EraseLine(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/profile/erase_dot.svg', width: 5, height: 5),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 21 / 14,
              color: Color(0xFF6E675F),
            ),
          ),
        ),
      ],
    );
  }
}
