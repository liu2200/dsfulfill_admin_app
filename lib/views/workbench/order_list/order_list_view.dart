import 'package:country_flags/country_flags.dart';
import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/events/application_event.dart';
import 'package:dsfulfill_admin_app/events/list_refresh_event.dart';
import 'package:dsfulfill_admin_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:dsfulfill_admin_app/views/components/button/main_button.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_admin_app/views/components/input/base_input.dart';
import 'package:dsfulfill_admin_app/views/components/list_refresh.dart';
import 'package:dsfulfill_admin_app/views/components/order_input/order_input.dart';
import 'package:dsfulfill_admin_app/views/workbench/order_list/order_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderListPage extends GetView<OrderListController> {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScafflod(
        title: '订单列表'.tr,
        hasBack: true,
        backgroundColor: AppStyles.background,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: LoadAssetImage(
              image: 'workbench/refresh',
              width: 24.w,
              height: 24.w,
              onPressed: () {
                ApplicationEvent.getInstance()
                    .event
                    .fire(ListRefreshEvent(type: 'refresh'));
              },
            ),
          ),
        ],
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppStyles.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OrderInput(
                          hintText: '平台编号'.tr,
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
                          // 使用 showModalBottomSheet 代替 endDrawer
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
                        },
                        child: SizedBox(
                          width: 35.w,
                          child: Obx(() => Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5.w),
                                    child: LoadAssetImage(
                                      image: 'workbench/filtrate',
                                      width: 24.w,
                                      height: 24.w,
                                    ),
                                  ),
                                  if (controller.activeFiltersCount.value > 0)
                                    Positioned(
                                      right: 2,
                                      top: 0,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minWidth: 18.w,
                                          minHeight: 18.w,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 1.w),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.activeFiltersCount.value}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(width: 5.w),
                    ],
                  ),
                  buildTabs()
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onPanEnd: (details) {
                  // 检测滑动手势
                  if (details.velocity.pixelsPerSecond.dx > 500) {
                    // 向右滑动 - 切换到上一个tab
                    if (controller.tabIndex.value > 0) {
                      controller.switchToTab(controller.tabIndex.value - 1);
                      ApplicationEvent.getInstance()
                          .event
                          .fire(ListRefreshEvent(type: 'refresh'));
                    }
                  } else if (details.velocity.pixelsPerSecond.dx < -500) {
                    // 向左滑动 - 切换到下一个tab
                    if (controller.tabIndex.value <
                        controller.orderListStatus.length - 1) {
                      controller.switchToTab(controller.tabIndex.value + 1);
                      ApplicationEvent.getInstance()
                          .event
                          .fire(ListRefreshEvent(type: 'refresh'));
                    }
                  }
                },
                child: Obx(() {
                  return RefreshView(
                    key: ValueKey(controller.tabIndex.value),
                    renderItem: (itemIndex, item) => buildItem(itemIndex, item),
                    refresh: controller.loadList,
                    more: controller.loadMoreList,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDrawer(BuildContext context) {
    // 不再需要 Drawer 包装
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('筛选'.tr,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterInput(
                        '平台SKU'.tr, controller.productKeywordController),
                    _buildFilterInput(
                        '物流单号'.tr, controller.logisticsKeywordController),
                    // _buildFilterDropdown('客户', controller.clientList),
                    _buildLabelText('客户'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.clientList,
                          getId: (e) => e.id.toString(),
                          getName: (e) => e.customName,
                          selectedId: controller.customerIdController,
                          onChanged: (id) {
                            controller.customerIdController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('店铺'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.shopList,
                          getId: (e) => e.id.toString(),
                          getName: (e) => e.shopName,
                          selectedId: controller.shopIdsController,
                          onChanged: (id) {
                            controller.shopIdsController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('平台'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.platformList,
                          getId: (e) => e['id'].toString(),
                          getName: (e) => e['label'].toString(),
                          selectedId: controller.platformController,
                          onChanged: (id) {
                            controller.platformController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('物流渠道'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.expressLinesList,
                          getId: (e) => e.id.toString(),
                          getName: (e) => e.name,
                          selectedId: controller.expressController,
                          onChanged: (id) {
                            controller.expressController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('物流轨迹'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.trajectoryList,
                          getId: (e) => e['id'].toString(),
                          getName: (e) => e['label'].toString(),
                          selectedId: controller.trackingStatusController,
                          onChanged: (id) {
                            controller.trackingStatusController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('国家'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          items: controller.countryList,
                          getId: (e) => e.id.toString(),
                          getName: (e) => e.name,
                          selectedId: controller.countryController,
                          onChanged: (id) {
                            controller.countryController.value = id;
                          },
                        )),
                    10.verticalSpace,
                    _buildLabelText('时间'.tr),
                    5.verticalSpace,
                    Obx(() => _buildSelectDropdown(
                          hint: '请选择'.tr,
                          showClear: false,
                          items: controller.timeRangeKeywordList,
                          getId: (e) => e['id'].toString(),
                          getName: (e) => e['label'].toString(),
                          selectedId: controller.timeRangeTypeController,
                          onChanged: (id) {
                            controller.timeRangeTypeController.value = id;
                          },
                        )),
                    5.verticalSpace,
                    _buildFilterDateRange(controller),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateActiveFiltersCount(); // 先更新筛选计数
                      Navigator.of(context).pop(); // 再关闭弹出窗口
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
                        style:
                            TextStyle(fontSize: 16.sp, color: AppStyles.white)),
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

  // 下拉选择框（带下拉菜单）
  Widget _buildSelectDropdown<T>({
    required String hint,
    required List<T> items,
    required String Function(T) getId,
    required String Function(T) getName,
    required RxString selectedId,
    required Function(String id) onChanged,
    bool showClear = true,
  }) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: double.infinity,
          height: 48.h,
          padding: EdgeInsets.only(bottom: 12.h, top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedId.value.isEmpty ? null : selectedId.value,
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppStyles.textGrey,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppStyles.textBlack,
                ),
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                items: items.map<DropdownMenuItem<String>>((item) {
                  final id = getId(item);
                  final name = getName(item);
                  return DropdownMenuItem<String>(
                    value: id,
                    child: Text(name),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return items.map((item) {
                    final name = getName(item);
                    return Text(name, style: TextStyle(fontSize: 14.sp));
                  }).toList();
                },
              ),
            ),
          ),
        ),
        if (showClear && selectedId.value.isNotEmpty)
          Positioned(
            right: 8.w,
            child: GestureDetector(
              onTap: () {
                selectedId.value = '';
                onChanged('');
              },
              child: Icon(Icons.clear, size: 18.sp, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildFilterInput(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp)),
          SizedBox(height: 4.h),
          BaseInput(
            controller: controller,
            hintText: '请输入'.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDateRange(OrderListController controller) {
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

  Widget buildItem(int index, dynamic item) {
    return GestureDetector(
      onTap: () {
        Routers.push(Routers.orderDetail, {
          'id': item.id,
          'abnormalStatus': item.abnormalStatus,
          'abnormal': item.abnormal
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
        decoration: BoxDecoration(
          color: AppStyles.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppStyles.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 第一行：店铺信息和状态
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppStyles.background,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 左侧店铺信息
                      Row(
                        children: [
                          LoadAssetImage(
                            image: 'workbench/${item.platform}',
                            width: 24.w,
                            height: 24.w,
                          ),
                          8.horizontalSpace,
                          SizedBox(
                            width: item.status == 4 ? 100.w : 140.w,
                            child: AppText(
                              text: item.shopName,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // 右侧状态标签
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEF9D4),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: AppText(
                          text: item.statusName,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppStyles.primary,
                        ),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  // 第二行：订单号和金额
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppText(
                            text: item.name,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      AppText(
                        text:
                            '${controller.currencyModel['code']} ${item.quotePrice?['total_price'] ?? '0'}',
                        fontSize: 14.sp,
                        color: const Color(0xFF2E9750),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  // 状态标签区域
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Wrap(
                      spacing: 10.w, // 水平间距
                      runSpacing: 8.h, // 垂直间距
                      alignment: WrapAlignment.start, // 水平左对齐
                      crossAxisAlignment: WrapCrossAlignment.center, // 垂直居中
                      children: [
                        if (item.isShipping == 1)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/shipment',
                                width: 20.w,
                                height: 20.w,
                              ),
                              4.horizontalSpace,
                              AppText(
                                text: '交运'.tr,
                                fontSize: 13.sp,
                                color: const Color(0xFF279A32),
                              ),
                            ],
                          ),
                        if (item.stockStatus == 'lack')
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/stockout',
                                width: 20.w,
                                height: 20.w,
                              ),
                              4.horizontalSpace,
                              AppText(
                                text: '缺货'.tr,
                                fontSize: 13.sp,
                                color: const Color(0xFFE37318),
                              ),
                            ],
                          ),
                        if (item.financialStatus == 4)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/refund',
                                width: 20.w,
                                height: 20.w,
                              ),
                              4.horizontalSpace,
                              AppText(
                                text: '退款'.tr,
                                fontSize: 13.sp,
                                color: const Color(0xFFFE5C73),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            12.verticalSpace,
            // 第三行：商品数量、客户和国旗
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // 商品数量
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: '${item.lineItems?.length} ${'件'.tr}',
                          fontSize: 14.sp,
                          color: AppStyles.textGrey,
                        ),
                        AppText(
                          text:
                              '${controller.currencyModel['code']} ${item.quotePrice?['goods_price'] ?? '0'}',
                          fontSize: 14.sp,
                          color: AppStyles.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      width: 1.w,
                      height: 38.h,
                      color: AppStyles.line,
                    ),
                    // 客户名称
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: AppText(
                            text: item.customerName ?? '',
                            fontSize: 14.sp,
                            color: AppStyles.textGrey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppText(
                          text:
                              '${controller.currencyModel['code']} ${item.quotePrice?['logistics_fee'] ?? '0'}',
                          fontSize: 14.sp,
                          color: AppStyles.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
                // 国旗
                if (item.countryCode != '')
                  CountryFlag.fromCountryCode(
                    item.countryCode,
                    height: 32.h,
                    width: 48.w,
                    borderRadius: 4,
                  ),
              ],
            ),
            if (item.abnormal != null && item.abnormal!.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD9DE),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFFE5C73)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...item.abnormal!
                        .map((abnormal) => Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: abnormal.description,
                                      fontSize: 14.sp,
                                      color: const Color(0xFFFE5C73),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTabs() {
    return TabBar(
        tabAlignment: TabAlignment.start,
        dividerHeight: 0,
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.w, color: AppStyles.primary),
          insets: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        controller: controller.tabController,
        labelPadding: EdgeInsets.only(right: 16.w),
        padding: EdgeInsets.only(left: 16.w),
        tabs: controller.orderListStatus
            .asMap()
            .keys
            .map(
              (index) => SizedBox(
                height: 28.h,
                child: Obx(
                  () => MainButton(
                    text:
                        '${controller.orderListStatus[index]['label']}${controller.orderListStatus[index]['show_count'] == true ? '(${controller.orderListStatus[index]['count'] == '' ? '0' : controller.orderListStatus[index]['count']})' : ''}',
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    onPressed: () {
                      controller.switchToTab(index);
                      ApplicationEvent.getInstance()
                          .event
                          .fire(ListRefreshEvent(type: 'refresh'));
                    },
                    backgroundColor: AppStyles.white,
                    fontSize: 12,
                    textColor: controller.tabIndex.value == index
                        ? AppStyles.primary
                        : AppStyles.textSub,
                  ),
                ),
              ),
            )
            .toList());
  }
}
