import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/storage/common_storage.dart';
import 'package:dsfulfill_cient_app/views/components/action_sheet.dart';
import 'package:dsfulfill_cient_app/views/me/me_controller.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MeView extends GetView<MeController> {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Column(
                  children: [
                    // Green header with user info
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 24.h, top: 25.h),
                      child: Column(
                        children: [
                          Obx(() => controller.token.value != ''
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 动态头像
                                    Obx(() => Container(
                                          width: 60.w,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                              child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60.r),
                                            child:
                                                controller.userAvatar.value ==
                                                        ''
                                                    ? LoadAssetImage(
                                                        image: 'center/logo',
                                                        width: 60.w,
                                                        height: 60.w,
                                                      )
                                                    : LoadNetworkImage(
                                                        url: controller
                                                            .userAvatar.value,
                                                        width: 60.w,
                                                        height: 60.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                          )),
                                        )),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: controller.teamInfo
                                                    .value['team_name'] ??
                                                '',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 4.h),
                                          AppText(
                                            text: controller.userName.value,
                                            fontSize: 13.sp,
                                            color: Colors.grey[600]!,
                                          ),
                                          SizedBox(height: 3.h),
                                          AppText(
                                            text: controller.userEmail.value,
                                            fontSize: 13.sp,
                                            color: AppStyles.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.03),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Routers.push(Routers.company);
                                        },
                                        child: LoadAssetImage(
                                          image: 'center/arrow_forward',
                                          width: 16.w,
                                          height: 16.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          '专注于 Dropshipping Agent 业务，为 Dropshipping行业打造量身定制 ERP 系统'
                                              .tr,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(height: 16.h),
                                    AppText(
                                      text: '三分钟开启订单之履'.tr,
                                      fontSize: 14.sp,
                                      color: AppStyles.textBlack,
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 42.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Routers.push(Routers.restLogin);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppStyles.primary,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        ),
                                        child: AppText(
                                          text: '免费开始'.tr,
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            'https://www.youtube.com/@DSFulfill'));
                                      },
                                      child: AppText(
                                        text: '如何做Dropshipping agent生意?'.tr,
                                        fontSize: 14.sp,
                                        color: const Color(0xFFFE5C73),
                                      ),
                                    ),
                                  ],
                                )),
                        ],
                      ),
                    ),
                  ],
                ),

                Obx(() => controller.token.value != ''
                    ? Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppStyles.line),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                _buildSimpleMenuItem('品牌介绍'.tr, 'setBrand'),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: const Divider(
                                      height: 1, color: AppStyles.line),
                                ),
                                _buildSimpleMenuItem('客户端主题'.tr, 'setTheme'),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      )
                    : const SizedBox()),

                Obx(() => controller.token.value != ''
                    ? Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppStyles.line),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                _buildSimpleMenuItem(
                                    '修改密码'.tr, 'modifyPassword'),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: const Divider(
                                      height: 1, color: AppStyles.line),
                                ),
                                _buildSimpleMenuItem('前往电脑版'.tr, 'web'),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      )
                    : const SizedBox()),

                // 悬浮的专属客户端卡片
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppStyles.line),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      _buildSimpleMenuItem('帮助中心'.tr, 'contactus'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(height: 1, color: AppStyles.line),
                      ),
                      _buildSimpleMenuItem('联系我们'.tr, 'contactus'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(height: 1, color: AppStyles.line),
                      ),
                      _buildSimpleMenuItem('语言'.tr, 'language'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(height: 1, color: AppStyles.line),
                      ),
                      _buildSimpleMenuItem('关于DSFulfill'.tr, 'about'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(height: 1, color: AppStyles.line),
                      ),
                      _buildSimpleMenuItem('隐私条款'.tr, 'privacypolicy'),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(() => controller.token.value != ''
                    ? buildLogoutButton()
                    : const SizedBox()),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleMenuItem(String title, String route) {
    return InkWell(
      onTap: () {
        if (route == 'web') {
          // 显示确认弹窗
          showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: AppText(
                  text: '前往电脑端网页'.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                content: AppText(
                  text: '转到dsfulfill网页。在电脑端访问网页(erp.dsfulfill.com)可以更加方便的进行管理。'
                      .tr,
                  fontSize: 14.sp,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭弹窗
                    },
                    child: AppText(
                      text: '取消'.tr,
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭弹窗
                      // 前往电脑版
                      launchUrl(Uri.parse('https://erp.dsfulfill.com'),
                          mode: LaunchMode.externalApplication);
                    },
                    child: AppText(
                      text: '确定'.tr,
                      color: AppStyles.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              );
            },
          );
        } else if (route == '') {
          return;
        } else if (route == 'contactus') {
          launchUrl(Uri.parse('https://dsfulfill.com'));
        } else if (route == 'privacypolicy') {
          launchUrl(Uri.parse('https://dsfulfill.com/privacy-policy'));
        } else if (route == 'language') {
          Get.bottomSheet(
            ActionSheet(
              datas: controller.languageList,
              onSelected: (index) async {
                var code = controller.languageList[index]['code']!;
                if (code == CommonStorage.getLanguage()?.countryCode) return;
                CommonStorage.setLanguage(code);
                Get.updateLocale(
                    Locale(code.split('_').first, code.split('_').last));
              },
            ),
          );
        } else {
          Routers.push(route);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                text: title,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12.w,
              color: AppStyles.textGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 42.h,
          child: ElevatedButton(
            onPressed: () {
              if (controller.token.value != '') {
                controller.onLogout(1);
              } else {
                Routers.push(Routers.login);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: AppText(
              text: controller.token.value != '' ? '退出登录'.tr : '登录'.tr,
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Obx(
          () => controller.isShow.value
              ? SizedBox(
                  width: double.infinity,
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onLogout(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.white,
                      elevation: 0,
                      side: const BorderSide(color: AppStyles.line),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: AppText(
                      text: '注销账号'.tr,
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
