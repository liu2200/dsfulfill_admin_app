import 'package:dsfulfill_cient_app/views/login/login_binding.dart';
import 'package:dsfulfill_cient_app/views/login/login_view.dart';
import 'package:dsfulfill_cient_app/views/tabbar/tabbar_binding.dart';
import 'package:dsfulfill_cient_app/views/tabbar/tabbar_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/collect_products/collect_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/collect_products/collect_page.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/online_recharge/online_recharge_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/recharge_detail/recharge_detail_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/recharge_detail/recharge_detail_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_list/transaction_viwe.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_detail/order_detall_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_detail/order_detall_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_list_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_list_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_quotation/order_quotation_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/order_quotation/order_quotation_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/product/product_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/product/product_detail/product_detail.binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/product/product_detail/product_detail.view.dart';
import 'package:dsfulfill_cient_app/views/workbench/product/product_view.dart';
import 'package:get/get.dart';
import 'package:dsfulfill_cient_app/state/app_state.dart';
import 'package:dsfulfill_cient_app/views/register/register_binding.dart';
import 'package:dsfulfill_cient_app/views/register/register_page.dart';
import 'package:dsfulfill_cient_app/views/forget_password/forget_password_binding.dart';
import 'package:dsfulfill_cient_app/views/forget_password/forget_password_view.dart';
import 'package:dsfulfill_cient_app/views/area_code/area_code_binding.dart';
import 'package:dsfulfill_cient_app/views/area_code/area_code_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/related_products/products_list_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/order_list/related_products/products_list_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/recharge_list/recharge_list_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/recharge_list/recharge_list_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/online_recharge/online_recharge_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_list/transaction_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_detail/transaction_detail_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/finance/transaction_detail/transaction_detail_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/client_list/client_list_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/client_list/client_list_view.dart';
import 'package:dsfulfill_cient_app/views/workbench/client_list/client_detail/client_detail_binding.dart';
import 'package:dsfulfill_cient_app/views/workbench/client_list/client_detail/client_detail_view.dart';
import 'package:dsfulfill_cient_app/views/me/company/company_binding.dart';
import 'package:dsfulfill_cient_app/views/me/company/company_view.dart';
import 'package:dsfulfill_cient_app/views/me/new_team/new_team_binding.dart';
import 'package:dsfulfill_cient_app/views/me/new_team/new_team_view.dart';
import 'package:dsfulfill_cient_app/views/me/set_brand/set_brand_binding.dart';
import 'package:dsfulfill_cient_app/views/me/set_brand/set_brand_view.dart';
import 'package:dsfulfill_cient_app/views/me/modify_password/modify_password_binding.dart';
import 'package:dsfulfill_cient_app/views/me/modify_password/modify_password_view.dart';

class Routers {
  static const String home = '/'; // 首页
  static const String login = '/login'; // 登录
  static const String productDetail = '/productDetail'; // 商品详情
  static const String shopList = '/shopList'; // 店铺列表
  static const String register = '/register'; // 注册
  static const String areaCode = '/areaCode'; // 区号
  static const String product = '/product'; // 产品管理
  static const String forgetPassword = '/forgetPassword'; // 忘记密码
  static const String collect = '/collect'; // 采集商品
  static const String orderList = '/orderList'; // 订单列表
  static const String orderDetail = '/orderDetail'; // 订单详情
  static const String orderQuotation = '/orderQuotation'; // 订单报价
  static const String productRelevancy = '/productRelevancy'; // 选择产品列表
  static const String rechargeList = '/rechargeList'; // 充值记录
  static const String rechargeDetail = '/rechargeDetail'; // 充值记录详情
  static const String onlineRecharge = '/onlineRecharge'; // 在线充值
  static const String transactionList = '/transactionList'; // 交易记录
  static const String transactionDetail = '/transactionDetail'; // 交易记录详情
  static const String clientList = '/clientList'; // 客户列表
  static const String clientDetail = '/clientDetail'; // 客户详情
  static const String company = '/company'; // 团队
  static const String newTeam = '/newTeam'; // 新建团队
  static const String setBrand = '/setBrand'; // 设置品牌
  static const String modifyPassword = '/modifyPassword'; // 修改密码

  static List filterList = [
    login,
    register,
    forgetPassword,
    areaCode,
  ];

  static List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: home,
      page: () => const TabbarView(),
      binding: TabbarBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: forgetPassword,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: areaCode,
      page: () => const AreaCodeView(),
      binding: AreaCodeBinding(),
    ),
    GetPage(
      name: product,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: productDetail,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: collect,
      page: () => const CollectPage(),
      binding: CollectBinding(),
    ),
    GetPage(
      name: orderList,
      page: () => const OrderListPage(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: orderDetail,
      page: () => const OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: orderQuotation,
      page: () => const OrderQuotationView(),
      binding: OrderQuotationBinding(),
    ),
    GetPage(
      name: productRelevancy,
      page: () => const ProductsListView(),
      binding: ProductsListBinding(),
    ),
    GetPage(
      name: rechargeList,
      page: () => const RechargeListPage(),
      binding: RechargeListBinding(),
    ),
    GetPage(
      name: rechargeDetail,
      page: () => const RechargeDetailPage(),
      binding: RechargeDetailBinding(),
    ),
    GetPage(
      name: onlineRecharge,
      page: () => const OnlineRechargeView(),
      binding: OnlineRechargeBinding(),
    ),
    GetPage(
      name: transactionList,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: transactionDetail,
      page: () => const TransactionDetailView(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: clientList,
      page: () => const ClientListView(),
      binding: ClientListBinding(),
    ),
    GetPage(
      name: clientDetail,
      page: () => const ClientDetailView(),
      binding: ClientDetailBinding(),
    ),
    GetPage(
      name: company,
      page: () => const CompanyView(),
      binding: CompanyBinding(),
    ),
    GetPage(
      name: newTeam,
      page: () => const NewTeamView(),
      binding: NewTeamBinding(),
    ),
    GetPage(
      name: setBrand,
      page: () => const SetBrandView(),
      binding: SetBrandBinding(),
    ),
    GetPage(
      name: modifyPassword,
      page: () => const ModifyPasswordView(),
      binding: ModifyPasswordBinding(),
    ),
  ];

  static Future<dynamic>? push(String route, [dynamic args]) {
    AppState? userInfo;
    try {
      userInfo = Get.find<AppState>();
    } catch (e) {
      Get.put(AppState());
      userInfo = Get.find<AppState>();
    }
    if (filterList.contains(route) || userInfo.token.isNotEmpty) {
      return Get.toNamed(route, arguments: args);
    } else {
      return Get.toNamed(login);
    }
  }

  static void pop([dynamic arguments]) {
    Get.back(result: arguments);
  }
}
