import 'package:dsfulfill_admin_app/storage/common_storage.dart';
import 'package:dsfulfill_admin_app/views/components/action_sheet.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
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
        child: LoadAssetImage(
          image: 'home/language',
          width: 24.w,
          height: 24.w,
        ),
      ),
    );
  }
}
