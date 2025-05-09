import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.fontSize = 14,
    this.borderRadius = 6,
    this.padding,
    this.visualDensity,
    this.borderWidth = 1,
    this.textFontWeight = FontWeight.w500,
    this.backgroundColor = AppStyles.primary,
    this.textColor = Colors.white,
    this.onPressed,
    this.child,
    this.width,
    this.hight,
  });
  final String? text;
  final double fontSize;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;
  final Color textColor;
  final FontWeight textFontWeight;
  final Function? onPressed;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final double? hight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: hight ?? 0,
        minWidth: width ?? 0,
      ),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
          ),
          visualDensity: visualDensity ?? VisualDensity.standard,
          padding: MaterialStateProperty.all(
              padding ?? EdgeInsetsDirectional.symmetric(horizontal: 12.w)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          side: MaterialStateProperty.all(BorderSide.none),
          elevation: MaterialStateProperty.all(0),
        ),
        child: text != null
            ? AppText(
                text: text!.tr,
                fontSize: fontSize,
                color: textColor,
                fontWeight: textFontWeight,
                lines: 2,
                textAlign: TextAlign.center,
              )
            : child!,
      ),
    );
  }
}
