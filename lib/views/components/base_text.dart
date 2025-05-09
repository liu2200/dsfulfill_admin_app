import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = AppStyles.textMain,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.lines,
    this.maxLines,
    this.overflow,
  });
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? lines;
  final int? maxLines;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
