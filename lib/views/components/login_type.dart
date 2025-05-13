import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget LoginType() {
  return Column(
    children: [
      Center(
        child: AppText(
          text: 'OR',
          color: AppStyles.textBlack,
          fontSize: 14.sp,
        ),
      ),
      SizedBox(height: 24.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     // Facebook login
          //   },
          //   child: LoadAssetImage(
          //     image: 'home/facebook',
          //     width: 40.w,
          //     height: 40.w,
          //   ),
          // ),
          // SizedBox(width: 32.w),
          GestureDetector(
            onTap: () {
              // Google login
            },
            child: LoadAssetImage(
              image: 'home/google',
              width: 40.w,
              height: 40.w,
            ),
          ),
        ],
      ),
    ],
  );
}
