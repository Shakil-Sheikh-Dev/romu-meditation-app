import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIcon extends StatelessWidget {
  const AuthIcon(this.asset, {super.key, this.size = 24});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}
