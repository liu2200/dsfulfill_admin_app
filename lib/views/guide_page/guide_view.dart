import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/picker/language_picker.dart';
import 'package:dsfulfill_cient_app/views/guide_page/guide_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GuideView extends GetView<GuideController> {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主轮播内容
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.guidePages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              final page = controller.guidePages[index];
              return _buildPageItem(page, index);
            },
          ),
          Positioned(
            top: 70.h,
            right: 10.w,
            child: const LanguagePicker(),
          ),

          // 底部指示器和按钮
          Positioned(
            bottom: 70.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // 指示器
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.guidePages.length,
                        (index) => Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? AppStyles.primary
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )),

                SizedBox(height: 30.h),

                // 按钮区域
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // 开始按钮
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyles.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Obx(() => AppText(
                                text: controller.currentPage.value ==
                                        controller.guidePages.length - 1
                                    ? '开始体验'.tr
                                    : '下一步'.tr,
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // 登录链接
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: '已有账户?'.tr,
                            color: Colors.black54,
                            fontSize: 14.sp,
                          ),
                          GestureDetector(
                            onTap: controller.skipGuide,
                            child: AppText(
                              text: ' ${'这里登录'.tr}',
                              color: AppStyles.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(Map<String, String> page, int index) {
    // 第一页特殊处理，添加背景图
    if (index == 0 && page['background'] != null) {
      return Stack(
        children: [
          // 背景图
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.h, // 限制背景图高度
            child: LoadAssetImage(
              image: page['background']!,
            ),
          ),
          // 内容
          _buildPageContent(page, index),
        ],
      );
    }

    // 其他页面
    return _buildPageContent(page, index);
  }

  Widget _buildPageContent(Map<String, String> page, int index) {
    return Column(
      children: [
        130.verticalSpaceFromWidth,
        // Logo 或标题区域
        Column(
          children: [
            if (page['title'] == 'DSFulfill')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadAssetImage(
                    image: 'home/logo',
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
                ],
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AppText(
                  text: page['title']?.tr ?? '',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppText(
                text: page['subtitle']?.tr ?? '',
                fontSize: 16.sp,
                color: index == 0 ? Colors.black87 : Colors.black54,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
          ],
        ),
        const Spacer(flex: 1),
        // 图片区域
        Expanded(
          flex: 3,
          child: LoadAssetImage(
            image: page['image'] ?? '',
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
