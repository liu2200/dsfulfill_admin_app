import 'package:dsfulfill_cient_app/config/app_config.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_scaffold.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/image_preview.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_network_image.dart';
import 'package:dsfulfill_cient_app/views/components/input/base_input.dart';
import 'package:dsfulfill_cient_app/views/components/upload_util.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/recharge_detail/recharge_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RechargeDetailPage extends GetView<RechargeDetailController> {
  const RechargeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScafflod(
      title: '转账支付详情'.tr,
      hasBack: true,
      backgroundColor: AppStyles.background,
      bottomNavigationBar: Obx(
        () {
          if (controller.rechargeDetail.value == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.rechargeDetail.value?.status == 0) {
            return Container(
              padding: EdgeInsets.only(
                  top: 10.h, bottom: 34.h, right: 16.h, left: 16.h),
              decoration: const BoxDecoration(
                color: AppStyles.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 审核拒绝逻辑
                        controller.auditStatus.value = 2;
                        controller.confirmAmount.value = TextEditingValue(
                            text: controller.rechargeDetail.value?.applyAmount
                                    .toString() ??
                                '');
                        _showApproveDialog(context, controller);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.white,
                        side: const BorderSide(color: AppStyles.textBlack),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: AppText(
                        text: '审核拒绝'.tr,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.confirmAmount.value = TextEditingValue(
                            text: controller.rechargeDetail.value?.applyAmount
                                    .toString() ??
                                '');
                        controller.auditStatus.value = 1;
                        _showApproveDialog(context, controller);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primary,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: AppText(
                        text: '审核通过'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          // Return an empty container if no conditions are met
          return const SizedBox.shrink();
        },
      ),
      body: Obx(() {
        final model = controller.rechargeDetail.value;
        if (model == null) {
          return const Center();
        }
        final amount = model.currency != 'USD' && model.payAmount > 0
            ? '${model.payAmount} ${model.currency} (${model.applyAmount} ${controller.currencyModel['code']})'
            : '${model.applyAmount} ${controller.currencyModel['code']}';
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 客户信息
                    _sectionCard('客户信息'.tr, [
                      _infoRow('客户ID'.tr, model.custom?.id.toString() ?? ''),
                      _infoRow('客户名称'.tr, model.custom?.customName ?? ''),
                      _infoRow('流水号'.tr, model.serialNo),
                      _infoRow('提交时间'.tr, model.createdAt),
                    ]),
                    SizedBox(height: 16.h),
                    // 支付信息
                    _sectionCard('支付信息'.tr, [
                      _infoRow('支付账号'.tr, model.payAccount),
                      _infoRow(
                          '支付方式'.tr, model.paymentTypeId == 1 ? '转账支付'.tr : ''),
                      _infoRow('支付金额'.tr, amount),
                      _infoRow('创建时间'.tr, model.createdAt),
                      _infoRow('客户截图'.tr, '',
                          isImage: true, images: model.applyImages),
                    ]),
                    SizedBox(height: 16.h),
                    if ([1, 3].contains(model.status))
                      // 确认支付信息
                      _sectionCard('确认支付信息'.tr, [
                        _infoRow('${'支付金额'.tr} (\$)',
                            model.confirmAmount.toString()),
                        _infoRow('备注'.tr, model.confirmRemark),
                        _infoRow('收款截图'.tr, '',
                            isImage: true, images: model.confirmImages),
                      ]),
                    if ([2].contains(model.status))
                      // 确认支付信息
                      _sectionCard('审核拒绝信息'.tr, [
                        _infoRow('${'支付金额'.tr} (\$)',
                            model.confirmAmount.toString()),
                        _infoRow('备注'.tr, model.confirmRemark),
                        _infoRow('收款截图'.tr, '',
                            isImage: true, images: model.confirmImages),
                      ]),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // 信息行
  Widget _infoRow(String label, String value,
      {bool isImage = false, List<String>? images}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 90, child: AppText(text: label, color: Colors.black54)),
          Expanded(
            child: isImage
                ? (images != null && images.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: images
                            .map((img) => Container(
                                margin: EdgeInsets.only(right: 8.w),
                                width: 50.w,
                                height: 50.w,
                                color: Colors.grey[300],
                                child: GestureDetector(
                                  onTap: () => showImagePreview(imageUrl: img),
                                  child: Image.network(img, fit: BoxFit.cover),
                                )))
                            .toList(),
                      )
                    : Container())
                : AppText(
                    text: value,
                    color: Colors.black87,
                    textAlign: TextAlign.right,
                  ),
          ),
        ],
      ),
    );
  }

  // 区块卡片
  Widget _sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
          SizedBox(height: 8.h),
          ...children,
        ],
      ),
    );
  }

  void _showApproveDialog(
      BuildContext context, RechargeDetailController controller) {
    final model = controller.rechargeDetail.value!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppStyles.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                          text: '审核'.tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, size: 22),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.auditStatus.value == 1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          AppText(
                              text: '充值金额'.tr,
                              fontSize: 14.sp,
                              color: Colors.black87),
                          SizedBox(height: 4.h),
                          AppText(
                              text: 'USD ${model.payAmount}',
                              fontSize: 20.sp,
                              color: AppStyles.primary,
                              fontWeight: FontWeight.bold),
                          SizedBox(height: 14.h),
                          AppText(
                              text: '确认金额'.tr,
                              fontSize: 14.sp,
                              color: Colors.black87),
                          SizedBox(height: 6.h),
                          BaseInput(
                            controller: controller.confirmAmount,
                            hintText: '请输入金额'.tr,
                          ),
                          SizedBox(height: 14.h),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  AppText(
                      text: '备注'.tr, fontSize: 14.sp, color: Colors.black87),
                  SizedBox(height: 6.h),
                  BaseInput(
                    controller: controller.confirmRemark,
                    hintText: '请选择'.tr,
                  ),
                  SizedBox(height: 14.h),
                  AppText(
                      text: '图片说明'.tr, fontSize: 14.sp, color: Colors.black87),
                  SizedBox(height: 6.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Obx(
                          () => Row(
                              children: controller.imageList
                                  .map((image) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Stack(
                                          children: [
                                            LoadNetworkImage(
                                              url: image,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              enablePreview: true,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.imageList
                                                      .remove(image);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            ImagePickers.imagePicker(
                              onSuccessCallback: (List<dynamic> images) async {
                                if (images.isNotEmpty) {
                                  controller.imageList.add(
                                      BaseUrls.getBaseUrl() +
                                          images[0]['path'].toString());
                                }
                              },
                              context: context,
                              child: CupertinoActionSheet(
                                title: Text('请选择上传方式'.tr),
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: Text('相册'.tr),
                                    onPressed: () {
                                      Navigator.pop(context, 'gallery');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Text('相机'.tr),
                                    onPressed: () {
                                      Navigator.pop(context, 'camera');
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context, '取消');
                                  },
                                  child: Text('取消'.tr),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.confirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primary,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('确定'.tr,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
