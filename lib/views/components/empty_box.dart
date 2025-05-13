import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget emptyBox({
  String? content,
  double? width,
  String? path,
}) {
  return Column(
    children: [
      Center(
        child: Column(
          children: [
            80.verticalSpaceFromWidth,
            LoadAssetImage(
              image: 'home/list_epmty',
              width: width ?? 130.w,
              fit: BoxFit.fitWidth,
            ),
            10.verticalSpaceFromWidth,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppText(
                text: content ?? 'No Date'.tr,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            AppText(
              text: 'Learn how to make your data'.tr,
              fontSize: 12.sp,
              color: const Color(0xFFFE5C73),
            ),
          ],
        ),
      ),
    ],
  );
}
