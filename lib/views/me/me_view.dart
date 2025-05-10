import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/me/me_controller.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MeView extends GetView<MeController> {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              child: AppText(
                text: '我的'.tr,
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            Obx(() {
              if (controller.token.value != '') {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Routers.push(Routers.company);
                    },
                    child: Row(
                      children: [
                        LoadAssetImage(
                          image: 'center/arrow_forward',
                          width: 16.w,
                          height: 16.w,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: const AppText(text: ''),
              );
            }),
          ],
        ),
      ),
      backgroundColor: AppStyles.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Green header with user info
                Container(
                  width: double.infinity,
                  color: AppStyles.primary,
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 24.w),
                          // 动态头像
                          Obx(() => Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: controller.token.value != ''
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.r),
                                          child:
                                              controller.userAvatar.value == ''
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
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.r),
                                          child: LoadAssetImage(
                                            image: 'center/logo',
                                            width: 60.w,
                                            height: 60.w,
                                          ),
                                        ),
                                ),
                              )),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Obx(
                                  () => AppText(
                                    text: controller.token.value != ''
                                        ? controller.userName.value
                                        : '请登录'.tr,
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Obx(() {
                                  if (controller.token.value != '') {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppStyles.primary,
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          border: Border.all(
                                            width: 1.w,
                                            color: Colors.white,
                                          )),
                                      child: AppText(
                                        text: '管理员'.tr,
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    );
                                  }
                                  ;
                                  return Container();
                                }),
                              ],
                            ),
                          ),
                          // Team button

                          SizedBox(height: 100.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // 悬浮的专属客户端卡片
            Obx(() {
              return Positioned(
                left: 16.w,
                right: 16.w,
                top: 80.h,
                child: Column(
                  children: [
                    if (controller.token.value != '')
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppStyles.line),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText(
                                  text: '专属客户端'.tr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Routers.push(Routers.setBrand, {
                                      'type': 'edit',
                                    });
                                  },
                                  child: Icon(
                                    Icons.settings_outlined,
                                    color: AppStyles.textGrey,
                                    size: 20.w,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () => controller.copyDomainToClipboard(),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AppText(
                                      text:
                                          '${'域名'.tr}：https://${controller.clientDomain.value?.domain ?? ''}',
                                      fontSize: 13.sp,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AppText(
                              text:
                                  '${'品牌'.tr}：${controller.customClient.value?.name ?? ''}',
                              fontSize: 13.sp,
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                AppText(
                                  text: 'LOGO：',
                                  fontSize: 13.sp,
                                ),
                                controller.customClient.value?.logo != null
                                    ? LoadNetworkImage(
                                        url: controller
                                                .customClient.value?.logo ??
                                            '',
                                        width: 60.w,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 48.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: AppStyles.textGrey
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.remove_red_eye,
                                    color: AppStyles.primary),
                                label: AppText(
                                  text: '预览'.tr,
                                  color: AppStyles.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppStyles.primary),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          _buildSimpleMenuItem('前往电脑版'.tr, 'web'),
                          const Divider(height: 1, color: AppStyles.line),
                          _buildSimpleMenuItem('教程中心'.tr, ''),
                          const Divider(height: 1, color: AppStyles.line),
                          _buildSimpleMenuItem('修改密码'.tr, 'modifyPassword'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Obx(() => buildLogoutButton()),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleMenuItem(String title, String route) {
    return InkWell(
      onTap: () {
        if (route == 'modifyPassword') {
          Routers.push(Routers.modifyPassword);
        } else if (route == 'web') {
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
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
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
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: () {
          if (controller.token.value != '') {
            controller.onLogout();
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
    );
  }
}
