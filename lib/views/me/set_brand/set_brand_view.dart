import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/image_preview.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/me/set_brand/set_brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetBrandView extends GetView<SetBrandController> {
  const SetBrandView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '用户设置'.tr,
      hasBack: true,
      backgroundColor: AppStyles.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadAssetImage(
              image: 'center/web-1',
              height: 240.h,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: '请输入您的品牌名称'.tr,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 30.h),
                  BaseInput(
                    controller: controller.siteNameController,
                    hintText: '请输入品牌名称'.tr,
                    borderColor: AppStyles.textBlack,
                    hintColor: AppStyles.textBlack,
                  ),
                  // 提交按钮
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: controller.submitForm,
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: AppStyles.primary,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Center(
                        child: AppText(
                          text: '继续'.tr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  InkWell(
                    onTap: () {
                      Routers.push(Routers.setBrandLogo);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Center(
                        child: AppText(
                          text: '跳过'.tr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F1F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 16.h),

            // // LOGO上传区域
            // AppText(
            //   text: '品牌LOGO'.tr,
            //   fontSize: 14.sp,
            //   fontWeight: FontWeight.w500,
            // ),
            // SizedBox(height: 8.h),
            // _buildImageUploader(
            //   isLogo: true,
            //   onTap: controller.uploadLogo,
            //   imageUrl: controller.logoUrl,
            // ),

            // // 品牌图标上传区域
            // SizedBox(height: 16.h),
            // AppText(
            //   text: '站点图标'.tr,
            //   fontSize: 14.sp,
            //   fontWeight: FontWeight.w500,
            // ),
            // SizedBox(height: 8.h),
            // _buildImageUploader(
            //   isLogo: false,
            //   onTap: controller.uploadIcon,
            //   imageUrl: controller.iconUrl,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploader({
    required bool isLogo,
    required Function() onTap,
    required Rx<String?> imageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showImagePreview(imageUrl: imageUrl.value);
              },
              child: Obx(() {
                return ClipRRect(
                  child: Image.network(
                    imageUrl.value!,
                    width: 80.w,
                    height: 80.w,
                  ),
                );
              }),
            ),
            SizedBox(width: 16.w),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.add,
                  color: AppStyles.textGrey,
                  size: 24.w,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        AppText(
          text: isLogo
              ? '品牌LOGO是您的客户端页面左上角显示的LOGO，它应为长方形，像素至少为154 x 37。'.tr
              : '网站图标是您在浏览器标签页、书签栏和 WordPress 移动应用程序中看到的图标。它应为正方形，推荐尺寸为 32 × 32。'
                  .tr,
          fontSize: 10.sp,
          color: const Color(0xFFFE5C73),
        ),
      ],
    );
  }
}
