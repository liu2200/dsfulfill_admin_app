import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/email_login/email_verify/email_verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailVerifyView extends GetView<EmailVerifyController> {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadAssetImage(
                      image: 'home/logo',
                      width: 150.w,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // 描述文字  We email a verification code to xxxx@xxx.com . Enter the code to complete registeration
              AppText(
                text:
                    '${'我们向'.tr} ${controller.email.value} ${'发送验证码。请输入验证码完成注册。'.tr}',
                fontSize: 20.sp,
                color: AppStyles.textBlack,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 32.h),
              BaseInput(
                controller: controller.codeController,
                hintText: '验证码'.tr,
                borderColor: AppStyles.textBlack,
                hintColor: AppStyles.textBlack,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 43.h,
                child: ElevatedButton(
                  onPressed: () {
                    controller.nextStep();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: AppText(
                    text: '下一步'.tr,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 43.h,
                  child: ElevatedButton(
                    onPressed: controller.canGetCode.value
                        ? () {
                            controller.getCode();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F3F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: AppText(
                      text: controller.canGetCode.value
                          ? '重新发送'.tr
                          : '${controller.count.value}s'.tr,
                      color: const Color(0xFF1F1F1F),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
