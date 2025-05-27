import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/state/app_state.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/picker/language_picker.dart';
import 'package:dsfulfill_admin_app/views/firebase/notification.dart';
import 'package:dsfulfill_admin_app/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:share_plus/share_plus.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      appBar: AppBar(
        backgroundColor: AppStyles.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Obx(() {
              return Container(
                width: 43.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF34A853),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Center(
                  child: Text(
                    Get.find<AppState>().team['company_id'] == 0
                        ? '-'
                        : (Get.find<AppState>().team['team_name'] ?? '-')[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(width: 8.w),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  if (controller.token.value == '') {
                    Routers.push(Routers.restLogin);
                  }
                  if (Get.find<AppState>().team['company_id'] == 0) {
                    Routers.push(Routers.newTeam, {'type': 'no_team'});
                  }
                },
                child: AppText(
                  text: Get.find<AppState>().team['company_id'] == 0
                      ? '请先创建团队'.tr
                      : Get.find<AppState>().team['team_name'] ?? '请先登录'.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const LanguagePicker(),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppStyles.primary,
        onRefresh: () async {
          await controller.loadData();
        },
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            AppText(
              text: '营业情况'.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),
            Obx(
              () => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 13.h,
                crossAxisSpacing: 13.w,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard(
                      '订单收入'.tr,
                      controller.homeModel.value.orderStatistics?.orderIncome ??
                          '0',
                      '订单收入'.tr),
                  _buildStatCard(
                      '商品成本'.tr,
                      controller.homeModel.value.orderStatistics
                              ?.orderItemsCost ??
                          '0',
                      '商品成本'.tr),
                  _buildStatCard(
                      '物流成本'.tr,
                      controller.homeModel.value.orderStatistics
                              ?.orderLogisticsCost ??
                          '0',
                      '物流成本'.tr),
                  _buildStatCard(
                      '利润'.tr,
                      controller.homeModel.value.orderStatistics?.orderProfit ??
                          '0',
                      '利润'.tr),
                ],
              ),
            ),
            // 营业数据网格
            SizedBox(height: 32.h),
            AppText(
              text: '我的任务'.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 6.h),
            // 我的任务卡片
            Container(
              margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppStyles.line),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Obx(
                () => Column(
                  children: [
                    // Tab
                    SingleChildScrollView(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Notifications.getToken();
                            },
                            child: Container(
                              width: 100.w,
                              height: 32.h,
                              color: Colors.red,
                            ),
                          ),
                          _buildTab(
                              '${'订单'.tr} (${controller.orderListStatus.fold(0, (sum, element) => sum + (element['count'] as int))})',
                              controller.tabIndex.value == 0,
                              0),
                          SizedBox(width: 12.w),
                          _buildTab(
                              '${'充值'.tr} (${controller.homeModel.value.rechargeCount ?? 0})',
                              controller.tabIndex.value == 1,
                              1),
                          // SizedBox(width: 12.w),
                          // _buildTab(
                          //     '${'商品总数'.tr} (${controller.homeModel.value.goodsCount ?? 0})',
                          //     false),
                          // SizedBox(width: 12.w),
                          // _buildTab(
                          //     '${'物流渠道'.tr} (${controller.homeModel.value.expressLinesCount ?? 0})',
                          //     false),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // 任务项列表
                    if (controller.tabIndex.value == 0)
                      ...controller.orderListStatus
                          .map((item) => _buildTaskItem(
                                (item['label'] ?? '').toString().tr,
                                (item['count'] ?? 0).toString(),
                                item['index'] as int,
                                isLast: controller.orderListStatus.last == item,
                                type: 'order',
                              ))
                    else
                      ...controller.rechargeListStatus
                          .map((item) => _buildTaskItem(
                                (item['label'] ?? '').toString().tr,
                                (item['count'] ?? 0).toString(),
                                item['index'] as int,
                                isLast:
                                    controller.rechargeListStatus.last == item,
                                type: item['type'] as String,
                              ))
                  ],
                ),
              ),
            ),
            // 邀请客户使用卡片
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppStyles.line),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  LoadAssetImage(
                    image: 'home/transmit',
                    width: 45.w,
                    height: 45.h,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: '邀请客户使用'.tr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 4.h),
                        AppText(
                          text: '点击右侧复制邀请码，分享链接给您的客户。'.tr,
                          fontSize: 10.sp,
                          color: AppStyles.textGrey,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Get.find<AppState>().team['team_code'] != null) {
                        // 获取分享的邀请码
                        final shareText =
                            '${controller.clientUrl.value}/invite/${Get.find<AppState>().team['team_code']}';
                        // 使用Share.share打开iOS分享菜单
                        Share.share(shareText, subject: 'DSFulfill'.tr);
                      } else {
                        Get.snackbar('提示'.tr, '请先登录'.tr);
                      }
                    },
                    child: Icon(
                      Icons.copy,
                      color: AppStyles.primary,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subTitle) {
    return SizedBox(
      height: 50.h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppStyles.line),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: value,
                fontSize: 26.sp,
                color: AppStyles.primary,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 4.h),
              AppText(
                text: title,
                fontSize: 12.sp,
                color: AppStyles.textBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool isActive, int index) {
    return GestureDetector(
      onTap: () {
        controller.tabIndex.value = index;
      },
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isActive ? AppStyles.primary : const Color(0xFFEEEEEF),
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(
            color: isActive ? AppStyles.primary : const Color(0xFFEEEEEF),
            width: 1,
          ),
        ),
        child: Center(
          child: AppText(
            text: text,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppStyles.textBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(String title, String count, int index,
      {bool isLast = false, String type = 'order'}) {
    return GestureDetector(
      onTap: () {
        if (type == 'order') {
          Routers.push(Routers.orderList, {'status': index});
        } else {
          if (type == 'transfer') {
            Routers.push(Routers.rechargeList, {'status': '0'});
          } else {
            Routers.push(Routers.onlineRecharge, {'status': '0'});
          }
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 44.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppStyles.primary, width: 1),
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white,
                      ),
                      child: AppText(
                        text: count,
                        fontSize: 12.sp,
                        color: AppStyles.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.w,
                      color: AppStyles.textGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isLast)
            const Divider(
              height: 1,
              color: AppStyles.line,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
        ],
      ),
    );
  }
}
