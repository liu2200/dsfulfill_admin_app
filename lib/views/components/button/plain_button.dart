import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlainButton extends StatelessWidget {
  const PlainButton({
    super.key,
    this.text,
    this.fontSize = 14,
    this.borderRadius = 6,
    this.padding,
    this.visualDensity,
    this.borderWidth = 1,
    this.textFontWeight = FontWeight.w500,
    this.borderColor = AppStyles.primary,
    this.textColor = AppStyles.primary,
    this.onPressed,
    this.child,
    this.width,
    this.hight,
  });
  final String? text;
  final double fontSize;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
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
        minHeight: hight ?? 0,
        minWidth: width ?? 0,
      ),
      child: TextButton(
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
          side: MaterialStateProperty.all(
            BorderSide(color: borderColor, width: borderWidth),
          ),
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
