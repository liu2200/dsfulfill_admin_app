import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:dsfulfill_cient_app/views/components/picker/language_picker.dart';
import 'package:dsfulfill_cient_app/views/components/sms_code_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.white,
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
                  child: Column(
                    children: [
                      AppText(
                        text: '注册 DSFulfill'.tr,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8.h),
                      AppText(
                        text: '开启您的代发服务商之旅'.tr,
                        fontSize: 14.sp,
                        color: AppStyles.textGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Obx(() => controller.isEmailRegister.value
                    ? BaseInput(
                        controller: controller.emailController,
                        hintText: '请输入邮箱'.tr,
                      )
                    : inputPhoneView(context)),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: BaseInput(
                        controller: controller.codeController,
                        hintText: '请输入验证码'.tr,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Obx(() => SmsCodeButton(
                          account: controller.isEmailRegister.value
                              ? controller.emailNumber.value
                              : controller.mobileNumber.value,
                          smsType: controller.isEmailRegister.value
                              ? 'email'
                              : 'phone',
                          type: 'register',
                          onSuccess: () {
                            controller.onCountdown();
                          },
                          verifyWithServer: (String param) async {
                            return true;
                          },
                        ))
                  ],
                ),
                Obx(() => controller.isEmailRegister.value
                    ? Column(
                        children: [
                          SizedBox(height: 16.h),
                          BaseInput(
                            controller: controller.passwordController,
                            hintText: '密码'.tr,
                            obscureText: true,
                          ),
                          SizedBox(height: 16.h),
                          BaseInput(
                            controller: controller.confirmPasswordController,
                            hintText: '确认密码'.tr,
                            obscureText: true,
                          ),
                        ],
                      )
                    : const SizedBox()),
                SizedBox(height: 16.h),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.toggleRegisterType();
                    },
                    child: AppText(
                      text: controller.isEmailRegister.value
                          ? '手机号注册'.tr
                          : '邮箱注册'.tr,
                      fontSize: 14.sp,
                      color: AppStyles.primary,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.agreeTerms.value,
                          onChanged: (value) =>
                              controller.agreeTerms.value = value!,
                          activeColor: AppStyles.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        )),
                    Expanded(
                      child: Row(
                        children: [
                          AppText(
                            text: '阅读并同意'.tr,
                            fontSize: 14.sp,
                            color: AppStyles.textGrey,
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: 打开条款页面
                            },
                            child: AppText(
                              text: 'DSFulfill条款与条件'.tr,
                              fontSize: 12.sp,
                              color: AppStyles.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: AppText(
                      text: '立即注册'.tr,
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: '已有账号？'.tr,
                        fontSize: 14.sp,
                        color: AppStyles.textGrey,
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: AppText(
                          text: '立即登录'.tr,
                          fontSize: 14.sp,
                          color: AppStyles.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  inputPhoneView(BuildContext context) {
    var inputAccountView = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFFEAEAEB)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.fromLTRB(7.w, 0, 0, 2.h),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              controller.onTimezone();
            },
            child: Row(
              children: <Widget>[
                Obx(
                  () => AppText(
                    text:
                        '+${controller.formatTimezone(controller.areaNumber.value)}',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.horizontalSpace,
                SizedBox(
                  height: 12.h,
                  child: const VerticalDivider(
                    thickness: 2,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: BaseInput(
              controller: controller.mobileNumberController,
              hintText: '请输入手机号'.tr,
              isBorder: false,
            ),
          ),
        ],
      ),
    );
    return inputAccountView;
  }
}
