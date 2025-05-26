import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/components/picker/language_picker.dart';
import 'package:dsfulfill_admin_app/views/components/sms_code_btn.dart';
import 'package:dsfulfill_admin_app/views/forget_password/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: LanguagePicker(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AppText(
                    text: '找回密码'.tr,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.verticalSpaceFromWidth,
                Obx(
                  () => BaseInput(
                    controller: controller.accountController,
                    hintText:
                        controller.isEmailRegister.value ? '邮箱'.tr : '手机号'.tr,
                  ),
                ),
                20.verticalSpaceFromWidth,
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: BaseInput(
                          controller: controller.codeController,
                          hintText: '请输入验证码'.tr,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SmsCodeButton(
                        account: controller.accountNumber.value,
                        smsType: controller.isEmailRegister.value
                            ? 'email'
                            : 'phone',
                        type: 'forgot_password',
                        onSuccess: () {
                          // controller.onCountdown();
                        },
                        verifyWithServer: (String param) async {
                          return true;
                        },
                      )
                    ],
                  ),
                ),
                20.verticalSpaceFromWidth,
                BaseInput(
                  controller: controller.passwordController,
                  hintText: '新密码'.tr,
                  obscureText: true,
                  togglePasswordVisibility: true,
                ),
                20.verticalSpaceFromWidth,
                BaseInput(
                  controller: controller.confirmPasswordController,
                  hintText: '确认密码'.tr,
                  obscureText: true,
                  togglePasswordVisibility: true,
                ),
                16.verticalSpaceFromWidth,
                AppText(
                  text: '请输入8-16位，且带有 字母、数字、特殊符号三种字符组合的密码！'.tr,
                  fontSize: 10.sp,
                  color: AppStyles.textGrey,
                ),
                20.verticalSpaceFromWidth,
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.toggleRegisterType();
                    },
                    child: AppText(
                      text: controller.isEmailRegister.value
                          ? '手机号找回'.tr
                          : '邮箱找回'.tr,
                      color: AppStyles.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                20.verticalSpaceFromWidth,
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.confirmed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: AppText(
                      text: '提交'.tr,
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: GestureDetector(
                    onTap: () {
                      Routers.push(Routers.login);
                    },
                    child: AppText(
                      text: '已有账号？立即登录'.tr,
                      color: AppStyles.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
