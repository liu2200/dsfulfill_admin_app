import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:dsfulfill_cient_app/views/email_login/email_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailLoginView extends GetView<EmailLoginController> {
  const EmailLoginView({super.key});

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
              // 描述文字
              AppText(
                text: 'Email Login/Register'.tr,
                fontSize: 20.sp,
                color: AppStyles.textBlack,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 16.h),
              AppText(
                text: 'Please enter your email'.tr,
                fontSize: 14.sp,
                color: AppStyles.textBlack,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 32.h),
              BaseInput(
                controller: controller.emailController,
                hintText: '邮箱'.tr,
                borderColor: AppStyles.textBlack,
                hintColor: AppStyles.textBlack,
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
            ],
          ),
        ),
      ),
    );
  }
}
