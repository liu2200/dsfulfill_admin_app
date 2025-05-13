import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/me/set_theme/set_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SetThemeView extends GetView<SetThemeController> {
  const SetThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '用户设置'.tr,
      hasBack: true,
      backgroundColor: const Color(0xFFEDEDEB),
      actions: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: Get.context!,
              builder: (context) {
                return AlertDialog(
                  title: AppText(
                    text: '预览'.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  content: AppText(
                    text: '确定要跳转web(${controller.domain.value})端预览吗？'.tr.tr,
                    fontSize: 14.sp,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 关闭弹窗
                      },
                      child: AppText(
                        text: '取消'.tr,
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 关闭弹窗
                        // 前往电脑版
                        launchUrl(
                            Uri.parse('https://${controller.domain.value}'),
                            mode: LaunchMode.externalApplication);
                      },
                      child: AppText(
                        text: '确定'.tr,
                        color: AppStyles.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.w),
            child: LoadAssetImage(
              image: 'center/preview',
              height: 25.h,
              width: 25.w,
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // 手机模拟器框架
              Obx(() {
                return Center(
                  child: Container(
                    height: 500.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: LoadAssetImage(
                      image: controller.image.value,
                      height: 500.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),

              SizedBox(height: 30.h),

              // 主题标题
              AppText(
                text: 'Theme',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppStyles.textBlack,
              ),

              SizedBox(height: 20.h),

              // 颜色选择网格
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: controller.themeImages.length,
                itemBuilder: (context, index) {
                  return _buildColorItem(index);
                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  // 构建颜色选择项
  Widget _buildColorItem(int index) {
    return Obx(() {
      final isSelected = controller.selectedThemeIndex.value == index;
      final color = controller.themeImages[index]['appColor'];

      return GestureDetector(
        onTap: () => controller.selectTheme(index),
        child: Container(
          width: 65.w,
          height: 65.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          padding: EdgeInsets.all(2.w),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: isSelected
                ? Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  )
                : null,
          ),
        ),
      );
    });
  }
}
