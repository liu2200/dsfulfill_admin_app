import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/list_refresh.dart';
import 'package:dsfulfill_cient_app/views/components/order_input/order_input.dart';
import 'package:dsfulfill_cient_app/views/components/select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'recharge_list_controller.dart';

class RechargeListPage extends GetView<RechargeListController> {
  const RechargeListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // key: scaffoldKey,
      // endDrawer: _buildFilterDrawer(context),
      body: BaseScafflod(
        title: '转账充值'.tr,
        hasBack: true,
        backgroundColor: AppStyles.background,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppStyles.white,
              ),
              padding: EdgeInsets.only(bottom: 5.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OrderInput(
                          hintText: '流水号'.tr,
                          controller: controller.keywordController,
                          bgColor: AppStyles.white,
                          onSearch: (value) {
                            controller.keywordController.text = value;
                            ApplicationEvent.getInstance()
                                .event
                                .fire(ListRefreshEvent(type: 'refresh'));
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // 允许内容占据更大空间
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ),
                                ),
                                child: _buildFilterDrawer(context),
                              );
                            },
                          );
                          // scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: LoadAssetImage(
                          image: 'workbench/filtrate',
                          width: 25.w,
                          height: 25.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshView(
                renderItem: (index, item) => buildItem(item),
                refresh: controller.loadList,
                more: controller.loadMoreList,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(dynamic item) {
    return GestureDetector(
      onTap: () {
        Routers.push(Routers.rechargeDetail, {
          'id': item.id,
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.h, right: 15.h, left: 15.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：流水号+状态
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.serialNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: item.status == 1
                        ? const Color(0xFFDEF9D4)
                        : item.status == 0
                            ? const Color(0xFFfa8c16).withOpacity(0.2)
                            : const Color(0xFFf36a6a).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: AppText(
                    text: item.statusName,
                    color: item.status == 1
                        ? AppStyles.primary
                        : item.status == 0
                            ? const Color(0xFFfa8c16)
                            : const Color(0xFFf36a6a),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // 金额
            if (item.payAmount > 0)
              Row(
                children: [
                  AppText(
                    text: item.payAmount.toString(),
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  AppText(
                    text: item.currency.toString(),
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  AppText(
                    text:
                        '(${item.applyAmount.toString()} ${controller.currencyModel['code'].toString()})',
                    color: AppStyles.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ],
              ),
            if (item.payAmount < 0)
              AppText(
                text:
                    '(${item.applyAmount.toString()} ${controller.currencyModel['code'].toString()})',
                color: AppStyles.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            SizedBox(height: 8.h),
            // 底部：客户+时间
            Row(
              children: [
                Container(
                  width: 16.w,
                  height: 16.w,
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFBDBDBD),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item.custom?.customName ?? '',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Text(
                  item.createdAt,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 标签文本
  Widget _buildLabelText(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }

  Widget _buildFilterDrawer(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('筛选'.tr, style: TextStyle(fontSize: 16.sp)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelText('客户'.tr),
                      5.verticalSpace,
                      Obx(() => SelectDropdown(
                            hint: '请选择'.tr,
                            items: controller.clientList,
                            getId: (e) => e.id.toString(),
                            getName: (e) => e.customName,
                            selectedId: controller.customerIdController.value,
                            onChanged: (id) {
                              controller.customerIdController.value = id;
                            },
                          )),
                      10.verticalSpace,
                      _buildLabelText('状态'.tr),
                      5.verticalSpace,
                      Obx(() => SelectDropdown(
                            hint: '请选择'.tr,
                            items: controller.operation,
                            getId: (e) => e['id'].toString(),
                            getName: (e) => e['label'].toString().tr,
                            selectedId: controller.status.value,
                            onChanged: (id) {
                              controller.status.value = id;
                            },
                          )),
                      10.verticalSpace,
                      _buildLabelText('时间'.tr),
                      5.verticalSpace,
                      _buildFilterDateRange(controller),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).maybePop();
                        ApplicationEvent.getInstance()
                            .event
                            .fire(ListRefreshEvent(type: 'refresh'));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text('查询'.tr,
                          style: TextStyle(
                              fontSize: 16.sp, color: AppStyles.white)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.reset();
                        Navigator.of(context).maybePop();
                        ApplicationEvent.getInstance()
                            .event
                            .fire(ListRefreshEvent(type: 'refresh'));
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        side: const BorderSide(color: AppStyles.textBlack),
                      ),
                      child: Text('重置'.tr,
                          style: TextStyle(
                              fontSize: 16.sp, color: AppStyles.textBlack)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDateRange(RechargeListController controller) {
    Future<void> pickDate(BuildContext context, Rx<DateTime?> target) async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: target.value ?? now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        confirmText: "确定".tr,
        cancelText: "取消".tr,
        helpText: '请选择时间'.tr,
      );
      if (picked != null) target.value = picked;
    }

    String formatDate(DateTime? date) {
      if (date == null) return '请选择'.tr;
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return Obx(() => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          pickDate(Get.context!, controller.filterStartDate),
                      child: Container(
                        height: 48.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          controller.filterStartDate.value == null
                              ? '请选择'.tr
                              : formatDate(controller.filterStartDate.value),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: controller.filterStartDate.value == null
                                ? AppStyles.greyHint
                                : AppStyles.textBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text('—'),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          pickDate(Get.context!, controller.filterEndDate),
                      child: Container(
                        height: 48.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          formatDate(controller.filterEndDate.value),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: controller.filterEndDate.value == null
                                ? AppStyles.greyHint
                                : AppStyles.textBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
