import 'package:country_flags/country_flags.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({
    Key? key,
    required this.datas,
    required this.onSelected,
  }) : super(key: key);
  final List<Map<String, dynamic>> datas;
  final Function(int index) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...datas.asMap().entries.map(
                (e) => Container(
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      top: e.key != 0
                          ? const BorderSide(
                              color: Color(0xFFECECEC), width: 0.5)
                          : BorderSide.none,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsetsDirectional.symmetric(vertical: 5.h),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CountryFlag.fromCountryCode(
                          e.value['flag'],
                          height: 30.h,
                          width: 30.w,
                          borderRadius: 4,
                        ),
                        10.horizontalSpace,
                        AppText(
                          text: e.value['name'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onTap: () {
                      onSelected(e.key);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppStyles.line, width: 0.5),
              ),
            ),
            child: SafeArea(
              child: ListTile(
                contentPadding: EdgeInsetsDirectional.only(top: 5.h),
                onTap: () {
                  Navigator.pop(context);
                },
                title: AppText(
                  text: 'cancel'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
