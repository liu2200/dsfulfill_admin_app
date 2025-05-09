import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox({
    super.key,
    required this.child,
    this.padding,
    this.shadow,
    this.radius,
    this.margin,
  });
  final EdgeInsets? padding;
  final Widget child;
  final BoxShadow? shadow;
  final double? radius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 10.r),
        boxShadow: [
          shadow ??
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 15.r,
                spreadRadius: 1.r,
                color: const Color(0x1A000000),
              ),
        ],
      ),
      padding: padding,
      margin: margin ?? EdgeInsets.fromLTRB(16.w, 0, 16.w, 15.h),
      child: child,
    );
  }
}
