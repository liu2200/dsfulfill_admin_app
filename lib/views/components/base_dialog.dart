import 'dart:io';

import 'package:dsfulfill_admin_app/config/styles.dart';
import 'package:dsfulfill_admin_app/views/components/base_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/*
  公共弹窗
 */

class BaseDialog {
  // 确认弹窗
  static Future<bool?> confirmDialog(BuildContext context, String content,
      {String? confirmText,
      String? cancelText,
      bool showCancelButton = true,
      bool barrierDismissible = false}) {
    return Platform.isAndroid
        ? androidDialog(
            context,
            content,
            confirmText: confirmText,
            cancelText: cancelText,
            showCancelButton: showCancelButton,
            barrierDismissible: barrierDismissible,
          )
        : cupertinoConfirmDialog(
            context,
            content,
            showCancelButton: showCancelButton,
            barrierDismissible: barrierDismissible,
          );
  }

  // android 确认弹窗
  static Future<bool?> androidDialog(BuildContext context, String content,
      {String? confirmText,
      String? cancelText,
      bool showCancelButton = true,
      bool barrierDismissible = false}) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppStyles.line),
                    ),
                  ),
                  child: AppText(
                    text: content,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 44.h,
                  child: Row(
                    children: [
                      if (showCancelButton) ...[
                        Expanded(
                          child: TextButton(
                            child: AppText(
                              text: (cancelText ?? '取消'.tr),
                              fontSize: 14,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Container(
                          width: 1,
                          color: AppStyles.line,
                        ),
                      ],
                      Expanded(
                        child: TextButton(
                          child: AppText(
                            text: (confirmText ?? '确定'.tr),
                            fontSize: 14,
                            color: AppStyles.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  // ios 风格 确认弹窗
  static Future<bool?> cupertinoConfirmDialog(
    BuildContext context,
    String content, {
    String? title,
    bool showCancelButton = true,
    bool barrierDismissible = false,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog<bool>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Container(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 12.w, vertical: 10.h),
            child: AppText(
              text: content,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: AppText(
                text: (cancelText ?? '取消'.tr),
                fontSize: 14,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            CupertinoDialogAction(
              child: AppText(
                text: (confirmText ?? '确定'.tr),
                fontSize: 14,
                color: AppStyles.primary,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  // 普通弹窗
  static Future<bool?> normalDialog(
    BuildContext context, {
    String? title,
    double? titleFontSize,
    String? confirmText,
    bool barrierDismissible = true,
    required Widget child,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: ScreenUtil().screenHeight - 200,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title != null
                      ? Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: AppStyles.line),
                          )),
                          alignment: Alignment.center,
                          child: AppText(
                            text: title,
                            fontSize: titleFontSize ?? 15,
                          ),
                        )
                      : AppGaps.empty,
                  child,
                  AppGaps.line,
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: AppText(
                          text: (confirmText ?? 'confirm'.tr),
                          color: AppStyles.primary),
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
