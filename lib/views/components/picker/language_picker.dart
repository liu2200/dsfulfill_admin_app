import 'package:country_flags/country_flags.dart';
import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/storage/common_storage.dart';
import 'package:dsfulfill_cient_app/views/components/action_sheet.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({super.key});

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  List<Map<String, String>> languageList = [
    {'name': '中文简体', 'code': 'zh_CN', 'flag': 'CN'},
    {'name': 'English', 'code': 'en_US', 'flag': 'US'},
  ];

  void onLanguagePicker(String code) {
    Get.updateLocale(Locale(code.split('_').first, code.split('_').last));
    CommonStorage.setLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.bottomSheet(
            ActionSheet(
              datas: languageList,
              onSelected: (index) async {
                var code = languageList[index]['code']!;
                if (code == CommonStorage.getLanguage()?.countryCode) return;
                CommonStorage.setLanguage(code);
                Get.updateLocale(
                    Locale(code.split('_').first, code.split('_').last));
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppStyles.line),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Row(
            children: [
              CountryFlag.fromCountryCode(
                CommonStorage.getLanguage()?.countryCode ?? 'US',
                height: 25.h,
                width: 25.w,
                borderRadius: 4,
              ),
              SizedBox(width: 8.w),
              AppText(
                text: CommonStorage.getLanguage()?.countryCode == null ||
                        CommonStorage.getLanguage()?.countryCode == 'US'
                    ? 'English'
                    : '简体中文',
                fontSize: 14.sp,
              ),
              Icon(Icons.keyboard_arrow_down, size: 20.w),
            ],
          ),
        ),
      ),
    );
  }
}
