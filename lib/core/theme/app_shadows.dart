import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const soft = <BoxShadow>[
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
