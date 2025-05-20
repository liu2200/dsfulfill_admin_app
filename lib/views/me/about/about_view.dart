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
                text: '关于我们'.tr,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.h),

              // 公司介绍
              AppText(
                text:
                    'DSFulfill 是一款专为 Dropshipping Agents设计的软件解决方案，由深圳星辉鲸跃有限公司开发。星辉鲸跃成立于 2024年，总部位于中国深圳，是一家专注于为全球跨境提供轻量级软件解决方案的技术公司。'
                        .tr,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              SizedBox(height: 24.h),

              // 团队介绍
              AppText(
                text:
                    '星辉鲸跃团队由10多名成员组成，其中软件开发团队在跨境供应链软件服务方面拥有超过10年的经验。团队在o-C和To-B开发方面经验丰富，并拥育强大的国际服务能力。'
                        .tr,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
              SizedBox(height: 24.h),

              // 目标说明
              AppText(
                text:
                    'DSFulfill的目标是向全球的Dropshipping Agents提供先进的软件服务，包括管理端和客户端。该产品支持多种语言，并提供开放的API服务旨在为Dropshipping Agents提供高效可扩展和用户友好的软件解决方案。'
                        .tr,
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
                          text: controller.appVersion.value,
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
