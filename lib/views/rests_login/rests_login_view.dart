import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/rests_login/rests_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RestLoginView extends GetView<RestLoginController> {
  const RestLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),

              // Logo
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
                text: '您可以使用邮箱或使用您的社交媒体账号登录'.tr,
                fontSize: 15.sp,
                color: Colors.black87,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),

              Expanded(child: SizedBox(height: 20.h)),

              // // 社交媒体登录按钮
              // _buildSocialLoginButton(
              //   icon: Icons.apple,
              //   text: '使用Apple账号登录'.tr,
              //   backgroundColor: Colors.black,
              //   textColor: Colors.white,
              //   onTap: () => controller.handleAppleLogin(),
              // ),

              // SizedBox(height: 16.h),

              // _buildSocialLoginButton(
              //   icon: Icons.facebook,
              //   iconColor: Colors.blue,
              //   text: '使用Facebook账号登录'.tr,
              //   backgroundColor: Colors.white,
              //   textColor: Colors.black87,
              //   onTap: () => controller.handleFacebookLogin(),
              // ),

              // SizedBox(height: 16.h),
              Obx(
                () => controller.isShow.value
                    ? _buildSocialLoginButton(
                        svgIcon: 'home/google',
                        text: '使用Google账号登录'.tr,
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        onTap: () => controller.handleGoogleLogin(),
                      )
                    : const SizedBox(),
              ),

              SizedBox(height: 24.h),

              // 或分隔线
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AppText(
                      text: 'OR',
                      fontSize: 14.sp,
                      color: const Color(0xFF1F1F1F),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[300], thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Email登录按钮
              _buildEmailLoginButton(),
              SizedBox(height: 20.h),
              // Email登录按钮
              _buildPasswordLoginButton(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // 密码登录按钮
  Widget _buildPasswordLoginButton() {
    return Material(
      color: AppStyles.white,
      borderRadius: BorderRadius.circular(50.r),
      child: InkWell(
        onTap: () => controller.navigateToPasswordLogin(),
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          width: double.infinity,
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: const Color(0xFF1F1F1F)),
          ),
          child: AppText(
            text: '使用账号密码登录'.tr,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1F1F1F),
          ),
        ),
      ),
    );
  }

  // 社交媒体登录按钮
  Widget _buildSocialLoginButton({
    IconData? icon,
    String? svgIcon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(50.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          width: double.infinity,
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: const Color(0xFF1F1F1F)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (icon != null) Icon(icon, color: iconColor, size: 26.r),
              if (svgIcon != null)
                LoadAssetImage(
                  image: 'home/google',
                  width: 24.r,
                  height: 24.r,
                ),
              Expanded(
                child: AppText(
                  text: text,
                  fontSize: 14.sp,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Email登录按钮
  Widget _buildEmailLoginButton() {
    return Material(
      color: AppStyles.primary,
      borderRadius: BorderRadius.circular(50.r),
      child: InkWell(
        onTap: () => controller.navigateToEmailLogin(),
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          width: double.infinity,
          height: 44.h,
          alignment: Alignment.center,
          child: AppText(
            text: '使用Email开始'.tr,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
