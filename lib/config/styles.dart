import 'package:flutter/material.dart';

class AppStyles {
  static const Color primary = Color(0xFF279A32);
  static const Color textMain = Color(0xFF333333);
  static const Color textSub = Color(0xFF666666);
  static const Color grey9 = Color(0xFF999999);
  static const Color textRed = Color(0xFFFF0000);
  static const Color line = Color(0xFFE0E0E0);
  static const Color greyBg = Color(0xFFF5F6F7);
  static const Color greyHint = Color(0xFFC0C4CC);
  static const Color background = Color(0xFFF7F7F7);
  static const Color textGrey = Color(0xFF787878);
  static const Color textBlack = Color(0xFF1F1F1F);
  static const Color textGreyBg = Color(0xFFEBEEF2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color chartColor = Color(0xFFEE633C);
}

/// 间隔
class AppGaps {
  static Widget line = const SizedBox(
    height: 1,
    width: double.infinity,
    child: DecoratedBox(decoration: BoxDecoration(color: AppStyles.line)),
  );

  static Widget orderLine = const SizedBox(
    height: 1,
    width: double.infinity,
    child: DecoratedBox(decoration: BoxDecoration(color: AppStyles.line)),
  );

  static const Widget empty = SizedBox();
}
