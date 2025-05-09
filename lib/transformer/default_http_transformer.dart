import 'package:dsfulfill_cient_app/transformer/http_transformer.dart';
import 'package:dio/dio.dart';
import 'package:dsfulfill_cient_app/common/http_response.dart';

class DefaultHttpTransformer extends HttpTransformer {
  @override
  HttpResponse parse(Response response) {
    if (response.data["status"]) {
      return HttpResponse.success(response.data["data"],
          response.data["message"], response.data["meta"]);
    }
    return HttpResponse.failure(
        errorMsg: response.data["message"], errorCode: response.data["code"]);
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
