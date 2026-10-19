import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:romu/core/theme/app_colors.dart';
import 'package:romu/core/widgets/app_button.dart';
import 'package:romu/features/profile/viewmodels/account_view_model.dart';
import 'package:romu/features/profile/widgets/profile_avatar.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late final TextEditingController _name;
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    final account = ref.read(accountProvider);
    _name = TextEditingController(text: account.name);
    _email = TextEditingController(text: account.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _changePhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: const Color(0xFFFDFCFA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    'Take photo',
                    style: TextStyle(fontFamily: 'Jost', fontSize: 16, color: AppColors.ink),
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  title: const Text(
                    'Choose from gallery',
                    style: TextStyle(fontFamily: 'Jost', fontSize: 16, color: AppColors.ink),
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (source == null || !mounted) return;

    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      final directory = await getApplicationDocumentsDirectory();
      final previous = ref.read(accountProvider).photoPath;
      final saved = await File(picked.path).copy(
        '${directory.path}/profile_photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      if (previous != null) {
        final old = File(previous);
        if (old.path != saved.path && old.existsSync()) {
          await old.delete();
        }
      }
      await FileImage(saved).evict();
      ref.read(accountProvider.notifier).setPhoto(saved.path);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not use that photo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final photoPath = ref.watch(accountProvider.select((account) => account.photoPath));
    return Scaffold(
      backgroundColor: const Color(0xFFF1EDE7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: AppColors.ink,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => context.pop(),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(Icons.chevron_left, color: Color(0xFFFAF8F5), size: 26),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Edit profile',
                style: TextStyle(
                  fontFamily: 'Instrument Serif',
                  fontSize: 44,
                  fontWeight: FontWeight.w400,
                  height: 1.05,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Update how your account looks in Romù',
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  color: Color(0xFF6E675F),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDFCFA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFDDD6CC)),
                      ),
                      child: Row(
                        children: [
                          ProfileAvatar(path: photoPath),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Profile photo',
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 24 / 16,
                                    color: AppColors.ink,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'JPG or PNG, square, min 200px',
                                  style: TextStyle(
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
                          Material(
                            color: const Color(0xFFF1EDE7),
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: _changePhoto,
                              borderRadius: BorderRadius.circular(16),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6E675F),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _LabeledField(
                      label: 'Name',
                      child: _Input(
                        controller: _name,
                        icon: 'assets/images/profile/field_person.svg',
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _LabeledField(
                      label: 'Email',
                      child: _Input(
                        controller: _email,
                        icon: 'assets/images/profile/field_mail.svg',
                        color: const Color(0xFF9A938A),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _LabeledField(
                      label: 'Confirm Password',
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F4EF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDDD6CC)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              spreadRadius: -0.5,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/profile/field_lock.svg',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Text(
                                '••••••••',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.ink,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.push('/change-password'),
                              child: const Text(
                                'Change',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFD89A72),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Save changes',
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.onImage,
                borderColor: Colors.transparent,
                onPressed: () {
                  ref.read(accountProvider.notifier).update(
                    name: _name.text.trim().isEmpty ? 'Natasha Kazlauskaitė' : _name.text.trim(),
                    email: _email.text.trim().isEmpty ? 'natasha.k@email.com' : _email.text.trim(),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.controller,
    required this.icon,
    required this.color,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String icon;
  final Color color;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: AppColors.ink,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF7F4EF),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 14),
            child: SvgPicture.asset(icon, width: 24, height: 24),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 54, maxWidth: 54, minHeight: 24),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      ),
    );
  }
}

final _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xFFDDD6CC)),
);
