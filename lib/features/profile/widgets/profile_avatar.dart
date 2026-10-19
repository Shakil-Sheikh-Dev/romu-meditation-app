import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.path, this.size = 64});

  final String? path;
  final double size;

  @override
  Widget build(BuildContext context) {
    final file = path == null ? null : File(path!);
    return ClipOval(
      child: file != null && file.existsSync()
          ? Image.file(
              file,
              key: ValueKey(path),
              width: size,
              height: size,
              fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/images/profile/avatar.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
    );
  }
}
