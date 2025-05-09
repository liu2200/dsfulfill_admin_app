import 'package:dsfulfill_cient_app/config/routers.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/events/application_event.dart';
import 'package:dsfulfill_cient_app/events/list_refresh_event.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/list_refresh.dart';
import 'package:dsfulfill_cient_app/views/components/order_input/order_input.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/related_products/products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsListView extends GetView<ProductsListController> {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '选择产品'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: GestureDetector(
            onTap: () {
              Routers.push(Routers.collect);
            },
            child: AppText(
              text: '从1688采集'.tr,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppStyles.primary,
            ),
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
                OrderInput(
                  hintText: '商品名称'.tr,
                  controller: controller.keywordController,
                  bgColor: AppStyles.white,
                  onSearch: (value) {
                    controller.keywordController.text = value;
                    ApplicationEvent.getInstance()
                        .event
                        .fire(ListRefreshEvent(type: 'refresh'));
                  },
                ),
                5.verticalSpaceFromWidth,
              ],
            ),
          ),
          Expanded(
            child: RefreshView(
              renderItem: (index, item) => buildItem(index, item, context),
              refresh: controller.loadList,
              more: controller.loadMoreList,
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(int index, dynamic item, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.getGoodsSkuList(item.id);
        final navigator = Navigator.of(context);
        var result = await showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return _ProductOptionsSheet(options: item.options, item: item);
          },
        );
        if (result != null) {
          navigator.pop(result);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 规格弹窗组件，支持product_model.dart的Option结构
class _ProductOptionsSheet extends StatelessWidget {
  final List options;
  final dynamic item;
  const _ProductOptionsSheet({required this.options, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsListController>();
    return Container(
      height: 480.w, // 固定高度
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.all(16.w),
      child: Stack(
        children: [
          // 主体内容
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16.h, right: 40),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (var optIndex = 0;
                        optIndex < options.length;
                        optIndex++)
                      if ((options[optIndex].name ?? '')
                          .toString()
                          .trim()
                          .isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: options[optIndex].name,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            Obx(() => Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (var spec in options[optIndex].specs)
                                      if ((spec.name ?? '')
                                          .toString()
                                          .trim()
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            controller.selectSpec(
                                                spec.name, optIndex);
                                          },
                                          child: Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 180.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 6.h),
                                            decoration: BoxDecoration(
                                              color: controller.attrs.length >
                                                          optIndex &&
                                                      controller.attrs[
                                                              optIndex] ==
                                                          spec.name
                                                  ? AppStyles.primary
                                                      .withOpacity(0.1)
                                                  : const Color(0xFFF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                color: controller.attrs.length >
                                                            optIndex &&
                                                        controller.attrs[
                                                                optIndex] ==
                                                            spec.name
                                                    ? AppStyles.primary
                                                    : const Color(0xFFE5E5E5),
                                              ),
                                            ),
                                            child: Text(
                                              spec.name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: controller.attrs.length >
                                                            optIndex &&
                                                        controller.attrs[
                                                                optIndex] ==
                                                            spec.name
                                                    ? AppStyles.primary
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                  ],
                                )),
                            16.verticalSpaceFromWidth,
                          ],
                        ),
                    Obx(() => controller.selectSku.value != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: '已选择'.tr,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              8.verticalSpaceFromWidth,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: const Color(0xFFE5E5E5)),
                                ),
                                padding: EdgeInsets.all(12.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        AppText(
                                          text: 'SKU',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(width: 8.w),
                                        AppText(
                                          text: controller
                                                  .selectSku.value?.skuId ??
                                              '',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        )
                                      ],
                                    ),
                                    8.verticalSpaceFromWidth,
                                    Row(
                                      children: [
                                        AppText(
                                          text: '重量'.tr,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(width: 8.w),
                                        AppText(
                                          text:
                                              '${controller.selectSku.value?.weight.toString()}g',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        )
                                      ],
                                    ),
                                    8.verticalSpaceFromWidth,
                                    Row(
                                      children: [
                                        AppText(
                                          text: '报价'.tr,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(width: 8.w),
                                        AppText(
                                          color: AppStyles.primary,
                                          text:
                                              '${controller.currencyModel['code']} ${controller.selectSku.value?.quotePrice}',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : const SizedBox())
                  ],
                ),
              ),
              // 只保留确定按钮
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.submitSku(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: AppText(
                        text: '确定'.tr,
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 右上角关闭按钮
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: const Icon(Icons.close, size: 24, color: AppStyles.textSub),
              onPressed: () => Navigator.of(context).pop(),
              splashRadius: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final dynamic spec;
  const _SpecChip({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Text(
        spec.name ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
