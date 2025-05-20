import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/login_type.dart';
import 'package:dsfulfill_cient_app/views/components/picker/language_picker.dart';
import 'package:dsfulfill_cient_app/views/components/sms_code_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import './login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     LanguagePicker(),
                //   ],
                // ),
                SizedBox(height: 32.h),
                Center(
                  child: AppText(
                    text: '登录 DSFulfill'.tr,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: AppText(
                    text: '开启您的代发货服务商之旅'.tr,
                    fontSize: 14.sp,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32.h),
                Obx(
                  () => BaseInput(
                    controller: controller.accountController,
                    hintText: controller.isEmailRegister.value
                        ? '手机号/邮箱'.tr
                        : '请输入手机号'.tr,
                  ),
                ),

                SizedBox(height: 20.h),

                Obx(
                  () => controller.isEmailRegister.value
                      ? BaseInput(
                          controller: controller.passwordController,
                          hintText: '密码'.tr,
                          obscureText: true,
                          togglePasswordVisibility: true,
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: BaseInput(
                                controller: controller.codeController,
                                hintText: '请输入验证码'.tr,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SmsCodeButton(
                              account: controller.mobileNumber.value,
                              smsType: 'phone',
                              type: 'login',
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
                // SizedBox(height: 20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Obx(
                //       () => Center(
                //         child: GestureDetector(
                //           onTap: () {
                //             controller.toggleRegisterType();
                //           },
                //           child: AppText(
                //             text: controller.isEmailRegister.value
                //                 ? '验证码登录'.tr
                //                 : '账号登录'.tr,
                //             color: AppStyles.primary,
                //             fontSize: 12.sp,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Center(
                //       child: GestureDetector(
                //         onTap: () {
                //           Routers.push(Routers.forgetPassword);
                //         },
                //         child: AppText(
                //           text: '忘记密码?'.tr,
                //           color: AppStyles.primary,
                //           fontSize: 12.sp,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: AppText(
                      text: '登录'.tr,
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       AppText(
                //         text: "还没有账号?".tr,
                //         fontSize: 14.sp,
                //         color: AppStyles.textBlack,
                //       ),
                //       TextButton(
                //         onPressed: () {
                //           Routers.push(Routers.register);
                //         },
                //         child: AppText(
                //           text: '立即注册'.tr,
                //           color: AppStyles.primary,
                //           fontSize: 14.sp,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
