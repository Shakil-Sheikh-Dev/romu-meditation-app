import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/l10n/app_localizations.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final _enabled = <String, bool>{
    'Daily reminder': true,
    'Streak reminders': true,
    'New sessions added': true,
    'Weekly progress recap': false,
    'Subscription & billing': true,
    'Product news': false,
  };
  final _days = <bool>[true, true, true, true, true, false, false];
  var _time = const TimeOfDay(hour: 21, minute: 0);

  String get _timeLabel {
    final hour = _time.hour.toString().padLeft(2, '0');
    final minute = _time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked == null) return;
    setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: AppColors.ink,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => context.pop(),
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.chevron_left, color: Color(0xFFFAF8F5), size: 26),
                  ),
                ),
              ),
            ),
            SizedBox(height: 22),
            Text(
              l10n.notifTitle,
              style: TextStyle(
                fontFamily: 'Instrument Serif',
                fontSize: 44,
                fontWeight: FontWeight.w400,
                height: 1.05,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.notifSubtitle,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
                color: Color(0xFF6E675F),
              ),
            ),
            SizedBox(height: 22),
            _Card(
              children: [
                _ToggleRow(
                  title: l10n.notifDaily,
                  subtitle: l10n.notifDailyBody,
                  value: _enabled['Daily reminder']!,
                  onChanged: (value) => setState(() => _enabled['Daily reminder'] = value),
                ),
                _Divider(),
                InkWell(
                  onTap: _pickTime,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.notifTime,
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 24 / 16,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        Text(
                          _timeLabel,
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 24 / 16,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'assets/images/profile/chevron.svg',
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const _Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = ((constraints.maxWidth - 36) / 7).clamp(32.0, 44.0);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var index = 0; index < _dayLabels.length; index++)
                            _DayDot(
                              label: _dayLabels[index],
                              selected: _days[index],
                              size: size,
                              onTap: () => setState(() => _days[index] = !_days[index]),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _SectionLabel(l10n.notifPractice),
            SizedBox(height: 8),
            _Card(
              children: [
                _ToggleRow(
                  title: l10n.notifStreak,
                  value: _enabled['Streak reminders']!,
                  onChanged: (value) => setState(() => _enabled['Streak reminders'] = value),
                ),
                _Divider(),
                _ToggleRow(
                  title: l10n.notifNew,
                  value: _enabled['New sessions added']!,
                  onChanged: (value) => setState(() => _enabled['New sessions added'] = value),
                ),
                _Divider(),
                _ToggleRow(
                  title: l10n.notifWeekly,
                  value: _enabled['Weekly progress recap']!,
                  onChanged: (value) => setState(() => _enabled['Weekly progress recap'] = value),
                ),
              ],
            ),
            SizedBox(height: 20),
            _SectionLabel(l10n.notifAccount),
            SizedBox(height: 8),
            _Card(
              children: [
                _ToggleRow(
                  title: l10n.notifBilling,
                  value: _enabled['Subscription & billing']!,
                  onChanged: (value) => setState(() => _enabled['Subscription & billing'] = value),
                ),
                _Divider(),
                _ToggleRow(
                  title: l10n.notifNews,
                  value: _enabled['Product news']!,
                  onChanged: (value) => setState(() => _enabled['Product news'] = value),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                l10n.notifNote,
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 18 / 12,
                  color: Color(0xFF7A7671),
                ),
              ),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  AppSettings.openAppSettings(type: AppSettingsType.notification);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    l10n.notifSettings,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: Color(0xFFD89A72),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDD6CC)),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFEFEBE5),
      child: SizedBox(height: 1, width: double.infinity),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Jost',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.8,
          color: Color(0xFF9A938A),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: AppColors.ink,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 18 / 12,
                      color: Color(0xFF7A7671),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _Toggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF33302C) : const Color(0xFFE4DFD8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({
    required this.label,
    required this.selected,
    required this.size,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF33302C) : const Color(0xFFF1EDE7),
          shape: BoxShape.circle,
          border: selected ? null : Border.all(color: const Color(0xFFDDD6CC)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 14,
            fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            color: selected ? const Color(0xFFFAF8F5) : const Color(0xFF9A938A),
          ),
        ),
      ),
    );
  }
}
