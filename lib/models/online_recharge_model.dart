import 'package:dsfulfill_cient_app/models/customer_model.dart';

class OnlineRechargeModel {
  late int id;
  late String checkStatusName;
  late int checkStatus;
  late String createdAt;
  late String payAmount;
  late String rechargeAmount;
  late String statusName;
  late int status;
  late String tradeNo;
  late String currency;
  late int type;
  late String typeName;
  CustomerModel? custom;

  OnlineRechargeModel({
    required this.id,
    required this.checkStatusName,
    required this.checkStatus,
    required this.createdAt,
    required this.payAmount,
    required this.rechargeAmount,
    required this.statusName,
    required this.status,
    required this.tradeNo,
    required this.type,
    required this.typeName,
    required this.currency,
    this.custom,
  });

  OnlineRechargeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkStatusName = json['check_status_name'];
    checkStatus = json['check_status'];
    createdAt = json['created_at'];
    payAmount = json['pay_amount'];
    rechargeAmount = json['recharge_amount'];
    statusName = json['status_name'];
    status = json['status'];
    tradeNo = json['trade_no'];
    type = json['type'];
    typeName = json['type_name'];
    currency = json['currency'];
    if (json['customer'] != null) {
      custom = CustomerModel.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'check_status_name': checkStatusName,
      'check_status': checkStatus,
      'created_at': createdAt,
      'pay_amount': payAmount,
      'recharge_amount': rechargeAmount,
      'status_name': statusName,
      'status': status,
      'trade_no': tradeNo,
      'type': type,
      'type_name': typeName,
      'customer': custom?.toJson(),
      'currency': currency,
    };
  }
}
