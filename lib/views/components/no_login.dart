import 'package:dsfulfill_admin_app/config/routers.dart';
import 'package:dsfulfill_admin_app/views/components/button/main_button.dart';
import 'package:dsfulfill_admin_app/views/components/image/load_asset_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget NoLogin() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadAssetImage(
          image: 'home/no_login',
          width: 120.w,
          height: 120.w,
        ),
        16.verticalSpaceFromWidth,
        MainButton(
          width: 200.w,
          hight: 40.h,
          text: '登录'.tr,
          onPressed: () => Routers.push(Routers.restLogin),
        ),
      ],
    ),
  );
}
