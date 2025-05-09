import 'package:dsfulfill_cient_app/common/http_client.dart';
import 'package:dsfulfill_cient_app/models/country_model.dart';
import 'package:dsfulfill_cient_app/models/express_lines_model.dart';
import 'package:dsfulfill_cient_app/models/generation_quote_model.dart';
import 'package:dsfulfill_cient_app/models/goods_category_model.dart';
import 'package:dsfulfill_cient_app/models/order_model.dart';
import 'package:dsfulfill_cient_app/models/product_model.dart';
import 'package:dsfulfill_cient_app/models/shop_model.dart';
import 'package:dsfulfill_cient_app/models/skus_model.dart';
import 'package:dsfulfill_cient_app/models/supplier_model.dart';

class WorkbenchService {
  static const String goodsApi = 'goods'; //商品列表
  static const String collectApi = 'collect-goods/collect-claim'; //产品收集
  static const String goodsCategoryApi = 'goods-category'; //商品分类API
  static const String supplierApi = 'supplier'; //获取供应商列表
  static const String orderApi = 'order'; //获取订单列表
  static const String shopApi = 'shop';
  static const String expressLinesApi = 'express-lines'; //获取物流渠道列表
  static const String countryApi = 'countries'; //获取国家列表
  static const String generationQuoteInfoApi = 'generation-quote-info';
  static const String orderQuoteInfoApi = 'order/order-quote-info'; //获取订单列表
  static const String goodsListApi = 'goods/sku-list'; //获取商品列表
  static const String mappingQuoteApi = 'order/mapping-quote'; //提交报价
  static const String moveToQuoteApi = 'order/move-to-quote'; //移入报价中
  static const String expressApi = 'express-companies/place'; //申请运单号
  static const String orderCancelApi = 'order/cancel'; //取消订单
  static const String orderCancelAndRefundApi = 'order/cancel-refund'; //取消订单并退款
  static const String ignoreAbnormalApi = 'order/ignore-abnormal'; //取消订单并退款

  static Future<bool> ignoreAbnormal(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(ignoreAbnormalApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<bool> orderCancelAndRefund(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(orderCancelAndRefundApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<bool> orderCancel(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(orderCancelApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  //申请运单号
  static Future<bool> expressCompanies(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance.post(expressApi, data: params).then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

//移入报价中
  static Future<bool> platformAbnormalMoveToQuote(
      Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .post(moveToQuoteApi, data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  static Future<Map<String, dynamic>?> mappingQuote(
      id, Map<String, dynamic> params) async {
    Map<String, dynamic>? result;
    await ApiConfig.instance
        .post('$mappingQuoteApi/$id', data: params)
        .then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  //获取商品列表
  static Future<List<SkusModel>> getGoodsSkuList(
      Map<String, dynamic> params) async {
    List<SkusModel> result = [];
    await ApiConfig.instance
        .get(goodsListApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(SkusModel.fromJson(data));
        });
      }
    });
    return result;
  }

  //订单报价信息
  static Future<Map<String, dynamic>?> orderQuoteInfo(id) async {
    Map<String, dynamic>? result;
    await ApiConfig.instance.get('$orderQuoteInfoApi/$id').then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  static Future<GenerationQuoteModel?> generationQuoteInfo(
      id, Map<String, dynamic> params) async {
    GenerationQuoteModel? result;
    await ApiConfig.instance
        .post('order/$id/$generationQuoteInfoApi', data: params)
        .then((response) {
      if (response.ok) {
        result = GenerationQuoteModel.fromJson(response.data);
      }
    });
    return result;
  }

  //订单详情
  static Future<Map<String, dynamic>?> getOrderDetails(id) async {
    Map<String, dynamic>? result;
    await ApiConfig.instance.get('$orderApi/$id').then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  //获取国家列表
  static Future<List<CountryModel>> getCountryList() async {
    List<CountryModel> result = [];
    await ApiConfig.instance.get(countryApi).then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(CountryModel.fromJson(data));
        });
      }
    });
    return result;
  }

  //获取物流渠道列表
  static Future<List<ExpressLinesModel>> getExpressList(
      Map<String, dynamic> params) async {
    List<ExpressLinesModel> result = [];
    await ApiConfig.instance
        .get(expressLinesApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(ExpressLinesModel.fromJson(data));
        });
      }
    });
    return result;
  }

//获取店铺列表
  static Future<List<ShopModel>> getShopList(
      Map<String, dynamic> params) async {
    List<ShopModel> result = [];
    await ApiConfig.instance
        .get(shopApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(ShopModel.fromJson(data));
        });
      }
    });
    return result;
  }

  //商品列表
  static Future<Map> getOrderList([Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<OrderModel> orderList = <OrderModel>[];
    await ApiConfig.instance
        .get(orderApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          orderList.add(OrderModel.fromJson(data));
        });
      }
      result = {
        "dataList": orderList,
        'total': response.meta?['last_page'],
        'pageIndex': response.meta?['current_page']
      };
    });
    return result;
  }

  //收集产品
  static Future<bool> collectProduct(Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance.post(collectApi, data: params).then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  //获取供应商列表
  static Future<List<SupplierModel>> getSupplierList(
      Map<String, dynamic> params) async {
    List<SupplierModel> result = [];
    await ApiConfig.instance
        .get(supplierApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          result.add(SupplierModel.fromJson(data));
        });
      }
    });
    return result;
  }

  //商品分类
  static Future<List<GoodsCategoryModel>> getGoodsCategory(
      Map<String, dynamic> params) async {
    List<GoodsCategoryModel> result = [];
    try {
      await ApiConfig.instance
          .get(goodsCategoryApi, queryParameters: params)
          .then((response) {
        if (response.ok) {
          final List<dynamic> dataList = response.data;
          for (var data in dataList) {
            if (data is Map<String, dynamic>) {
              result.add(GoodsCategoryModel.fromJson(data));
            }
          }
        }
      });
    } catch (e) {}
    return result;
  }

  static Future<bool> updateGoods(id, Map<String, dynamic> params) async {
    bool result = false;
    await ApiConfig.instance
        .put('$goodsApi/$id', data: params)
        .then((response) {
      if (response.ok) {
        result = true;
      }
    });
    return result;
  }

  //商品详情
  static Future<Map<String, dynamic>?> getGoodsDetails(id) async {
    Map<String, dynamic>? result;
    await ApiConfig.instance.get('$goodsApi/$id').then((response) {
      if (response.ok) {
        result = response.data;
      }
    });
    return result;
  }

  //商品列表
  static Future<Map> getGoodsList([Map<String, dynamic>? params]) async {
    var page = (params is Map) ? params!['page'] : 1;
    Map result = {"dataList": null, 'total': 1, 'pageIndex': page};
    List<ProductModel> productList = <ProductModel>[];
    await ApiConfig.instance
        .get(goodsApi, queryParameters: params)
        .then((response) {
      if (response.ok) {
        response.data.forEach((data) {
          productList.add(ProductModel.fromJson(data));
        });
      }
      result = {
        "dataList": productList,
        'total': response.meta?['last_page'],
        'pageIndex': response.meta?['current_page']
      };
    });
    return result;
  }
}
