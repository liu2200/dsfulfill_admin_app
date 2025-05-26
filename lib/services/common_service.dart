import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dsfulfill_admin_app/common/http_client.dart';

class CommonService {
  static const String uploadImageApi = 'upload/images';
  /*
    上传图片
   */
  static Future<List> uploadImage(File file) async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      "images[0][file]": await MultipartFile.fromFile(path, filename: name)
    });
    List<dynamic> result = [];
    await ApiConfig.instance
        .post(
      uploadImageApi,
      data: formData,
    )
        .then((response) {
      result = response.data;
    });
    return result;
  }
}
