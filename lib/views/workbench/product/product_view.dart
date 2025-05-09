import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/button/main_button.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/components/list_refresh.dart';
import 'package:dsfulfill_cient_app/views/components/order_input/order_input.dart';
import 'package:dsfulfill_cient_app/views/workbench/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '产品管理'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppStyles.white,
            ),
            child: Column(
              children: [
                OrderInput(
                  hintText: '商品名称'.tr,
                  controller: controller.keywordController,
                  bgColor: AppStyles.white,
                  onSearch: (value) {
                    controller.keywordController.text = value;
                    // controller.getOrdersCount();
                    ApplicationEvent.getInstance()
                        .event
                        .fire(ListRefreshEvent(type: 'refresh'));
                  },
                ),
                buildTabs(),
              ],
            ),
          ),
          Expanded(
            child: RefreshView(
              renderItem: (index, item) => buildItem(index, item),
              refresh: controller.loadList,
              more: controller.loadMoreList,
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(int index, dynamic item) {
    return GestureDetector(
      onTap: () {
        Routers.push(Routers.productDetail, {'id': item.id});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                item.coverImage,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.goodsName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Spu: ${item.spu}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppStyles.textSub,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/attach_money',
                                width: 15.w,
                                height: 15.w,
                              ),
                              Text(
                                ' USD ${item.minPurchasePrice ?? '--'}~${item.maxPurchasePrice ?? '--'}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppStyles.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadAssetImage(
                                image: 'workbench/account_balance_wallet',
                                width: 15.w,
                                height: 15.w,
                              ),
                              Text(
                                ' CNY ${item.minSalePrice ?? '--'}~${item.maxSalePrice ?? '--'}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: item.status == 1
                              ? AppStyles.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Text(
                          item.statusName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabs() {
    List<Map<String, String>> tabs = [
      {'label': '全部'.tr, 'count': '0'},
      {'label': '待审核'.tr, 'count': '0'},
      {'label': '审核通过'.tr, 'count': '0'},
    ];
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
        tabs: tabs
            .asMap()
            .keys
            .map(
              (index) => SizedBox(
                height: 28.h,
                child: Obx(
                  () => MainButton(
                    text:
                        '${tabs[index]['label']}(${tabs[index]['count'] == '' ? '0' : tabs[index]['count']})',
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    onPressed: () {
                      controller.tabIndex.value = index;
                      controller.tabController.animateTo(index);
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
