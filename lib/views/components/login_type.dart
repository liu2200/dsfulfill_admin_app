import 'package:dsfulfill_cient_app/config/styles.dart';
import 'package:dsfulfill_cient_app/services/user_service.dart';
import 'package:dsfulfill_cient_app/views/components/base_text.dart';
import 'package:dsfulfill_cient_app/views/components/image/load_asset_image.dart';
import 'package:dsfulfill_cient_app/views/firebase/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginType extends StatelessWidget {
  final SocalLogin _socalLogin = SocalLogin();

  LoginType({Key? key}) : super(key: key);

  // 处理Google登录
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      EasyLoading.show(status: '登录中...');
      final idToken = await _socalLogin.signInGoogle();
      if (idToken != null) {
        final result = await UserService.loginFirebase({
          'id_token': idToken,
        });
        EasyLoading.dismiss();
        if (result != null) {
          // 登录成功
          if (result.containsKey('token')) {
            Get.back(); // 返回上一页
          }
        }
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('登录失败: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AppText(
            text: 'OR',
            color: AppStyles.textBlack,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _handleGoogleSignIn(context),
              child: LoadAssetImage(
                image: 'home/google',
                width: 40.w,
                height: 40.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
