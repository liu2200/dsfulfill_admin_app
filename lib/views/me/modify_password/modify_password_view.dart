import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/components/sms_code_btn.dart';
import 'package:dsfulfill_admin_app/views/me/modify_password/modify_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ModifyPasswordView extends GetView<ModifyPasswordController> {
  const ModifyPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '修改密码'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppStyles.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: '账号'.tr,
                fontSize: 14.sp,
                color: AppStyles.textBlack,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 5.h),
              BaseInput(
                controller: controller.phoneController,
                hintText: '请输入账号'.tr,
                keyboardType: TextInputType.phone,
                enabled: false,
              ),
              SizedBox(height: 16.h),
              _buildLabelText('验证码'.tr),
              Row(
                children: [
                  Expanded(
                    child: BaseInput(
                      controller: controller.verificationCodeController,
                      hintText: '请输入验证码'.tr,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Obx(
                    () => SmsCodeButton(
                      account: controller.phone.value,
                      smsType: controller.isRegister.value ? 'phone' : 'email',
                      type: 'forgot_password',
                      onSuccess: () {
                        // controller.onCountdown();
                      },
                      verifyWithServer: (String param) async {
                        return true;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildLabelText('新密码'.tr),
              BaseInput(
                controller: controller.newPasswordController,
                hintText: '请输入新密码'.tr,
                obscureText: true,
                togglePasswordVisibility: true,
              ),
              SizedBox(height: 16.h),
              _buildLabelText('确认密码'.tr),
              BaseInput(
                controller: controller.confirmPasswordController,
                hintText: '请输入确认密码'.tr,
                obscureText: true,
                togglePasswordVisibility: true,
              ),
              SizedBox(height: 16.h),
              AppText(
                text: '注意事项'.tr,
                fontSize: 13.sp,
                color: AppStyles.textBlack,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 5.h),
              AppText(
                text: '请输入8-16位，且带有 字母、数字、特殊符号三种字符组合的密码！'.tr,
                fontSize: 12.sp,
                color: AppStyles.textBlack,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppStyles.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    controller.validateConfirmPassword();
                  },
                  child: AppText(
                    text: '提交'.tr,
                    color: Colors.white,
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

  // 标签文本
  Widget _buildLabelText(String text) {
    return Row(
      children: [
        Text(
          '*',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.red,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          text.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppStyles.textBlack,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
