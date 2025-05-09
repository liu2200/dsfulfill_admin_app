import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:dsfulfill_cient_app/views/components/list_refresh.dart';
import 'package:dsfulfill_cient_app/views/components/order_input/order_input.dart';
import 'package:dsfulfill_cient_app/views/components/select_dropdown.dart';
import 'package:dsfulfill_cient_app/views/workbench/client_list/client_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientListView extends GetView<ClientListController> {
  const ClientListView({super.key});
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: _buildFilterDrawer(context),
      body: BaseScafflod(
        title: '客户列表'.tr,
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
                          hintText: '客户ID'.tr,
                          controller: controller.keywordIdController,
                          bgColor: AppStyles.white,
                          onSearch: (value) {
                            controller.keywordIdController.text = value;
                            ApplicationEvent.getInstance()
                                .event
                                .fire(ListRefreshEvent(type: 'refresh'));
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState?.openEndDrawer();
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
    final customer = item;
    return GestureDetector(
      onTap: () {
        Routers.push(Routers.clientDetail, {
          'item': customer,
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.h, right: 15.h, left: 15.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
            // 顶部：客户名+标签
            Row(
              children: [
                AppText(
                  text: '${customer.id}-${customer.customName}',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 6.w),
                if (customer.groupName.isNotEmpty)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEF9D4),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: AppText(
                      text: customer.groupName,
                      color: AppStyles.primary,
                      fontSize: 13.sp,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.h),
            // 邮箱
            AppText(
              text: customer.customEmail,
              color: Colors.black54,
              fontSize: 15.sp,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15.h),
            // 底部：左时间，右余额
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 左侧时间信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          LoadAssetImage(
                            image: 'workbench/last',
                            width: 15.w,
                            height: 15.w,
                          ),
                          SizedBox(width: 6.w),
                          AppText(
                            text: customer.lastLoginTime,
                            color: Colors.black45,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          LoadAssetImage(
                            image: 'workbench/calendar',
                            width: 15.w,
                            height: 15.w,
                          ),
                          SizedBox(width: 6.w),
                          AppText(
                            text: customer.createdAt,
                            color: Colors.black45,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 右侧余额信息
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: '${'余额'.tr}：${customer.balance}',
                      color: AppStyles.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      constraints: BoxConstraints(maxWidth: 150.w),
                      child: AppText(
                        text: '${'剩余额度'.tr}：${customer.residualCredit}',
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
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
                      _buildLabelText('搜索类型'.tr),
                      5.verticalSpace,
                      Obx(() => SelectDropdown(
                            hint: '请选择'.tr,
                            items: controller.keywordTypeList,
                            getId: (e) => e['id'].toString(),
                            getName: (e) => e['label'].toString().tr,
                            selectedId: controller.keywordType.value,
                            showClear: false,
                            onChanged: (id) {
                              controller.keywordType.value = id;
                            },
                          )),
                      10.verticalSpace,
                      _buildLabelText('搜索内容'.tr),
                      5.verticalSpace,
                      BaseInput(
                        hintText: '请输入'.tr,
                        controller: controller.keywordController,
                      ),
                      10.verticalSpace,
                      _buildLabelText('客户组'.tr),
                      5.verticalSpace,
                      Obx(() => SelectDropdown(
                            hint: '请选择'.tr,
                            items: controller.clientGroupList,
                            getId: (e) => e.id.toString(),
                            getName: (e) => e.groupName,
                            selectedId: controller.groupId.value,
                            onChanged: (id) {
                              controller.groupId.value = id;
                            },
                          )),
                      10.verticalSpace,
                      _buildLabelText('员工'.tr),
                      5.verticalSpace,
                      Obx(() => SelectDropdown(
                            hint: '请选择'.tr,
                            items: controller.staffList,
                            getId: (e) => e.id.toString(),
                            getName: (e) => e.name,
                            selectedId: controller.staffId.value,
                            onChanged: (id) {
                              controller.staffId.value = id;
                            },
                          )),
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
}
