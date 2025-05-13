import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/me/about/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '关于我们'.tr,
      hasBack: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              AppText(
                text: 'About Us',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.h),

              // 公司介绍
              AppText(
                text:
                    'DSFulfill is a software solution specifically designed for Dropshipping Agents, developed by Shenzhen StellarWhale Technology Co., Ltd.. Founded in 2024 and headquartered in Shenzhen, China, StellarWhale Technology is a technology company focused on lightweight software solutions for global markets.',
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              SizedBox(height: 24.h),

              // 团队介绍
              AppText(
                text:
                    'The StellarWhale team consists of over 10 members, with the software development team having more than 10 years of experience in cross-border supply chain software services. The team is highly experienced in both To-C and To-B development and possesses strong international service capabilities.',
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              SizedBox(height: 24.h),

              // 目标说明
              AppText(
                text:
                    'The goal of DSFulfill is to provide advanced software services to Dropshipping Agents worldwide, including both admin and client interfaces. The product supports multiple languages and offers an open API service, aiming to deliver efficient, scalable, and user-friendly software solutions for Dropshipping agents.',
                fontSize: 14.sp,
                color: Colors.black87,
              ),

              SizedBox(height: 10.h),

              // 版权信息
              Center(
                child: Column(
                  children: [
                    AppText(
                      text: '@ 2024~2025',
                      fontSize: 13.sp,
                      color: AppStyles.textBlack,
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _launchURL('https://www.dsfulfill.com'),
                      child: AppText(
                        text: 'https://www.dsfulfill.com',
                        fontSize: 14.sp,
                        color: AppStyles.primary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(() => AppText(
                          text: controller.appVersion.value.split('.').first,
                          fontSize: 13.sp,
                          color: AppStyles.textBlack,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 打开网址
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
