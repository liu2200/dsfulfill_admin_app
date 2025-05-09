import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget emptyBox({
  String? content,
  double? width,
  String? path,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Column(
          children: [
            // ImgItem(
            //   path ?? 'list_epmty',
            //   width: width ?? 200.w,
            //   fit: BoxFit.fitWidth,
            // ),
            10.verticalSpaceFromWidth,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppText(
                text: content ?? 'noData'.tr,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
