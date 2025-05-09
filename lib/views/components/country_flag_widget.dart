import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryFlagWidget extends StatelessWidget {
  final String countryCode;
  final double? width;
  final double? height;
  final double borderRadius;

  const CountryFlagWidget({
    Key? key,
    required this.countryCode,
    this.width,
    this.height,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      countryCode,
      height: height ?? 32.h,
      width: width ?? 32.w,
      borderRadius: borderRadius,
    );
  }
}
