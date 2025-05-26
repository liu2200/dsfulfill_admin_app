import 'package:dsfulfill_admin_app/models/customer_model.dart';

class BalanceRecordModel {
  late double amount;
  late int id;
  late String createdAt;
  late String orderSn;
  late String remark;
  late String serialNo;
  late int sourceType;
  late String sourceTypeName;
  late int type;
  late String typeName;
  CustomerModel? custom;

  BalanceRecordModel({
    required this.amount,
    required this.id,
    required this.createdAt,
    required this.orderSn,
    required this.remark,
    required this.serialNo,
    required this.sourceType,
    required this.sourceTypeName,
    required this.type,
    required this.typeName,
    this.custom,
  });

  BalanceRecordModel.fromJson(Map<String, dynamic> json) {
    var amountRaw = json['amount'];
    if (amountRaw is int) {
      amount = amountRaw.toDouble();
    } else if (amountRaw is double) {
      amount = amountRaw;
    } else if (amountRaw is String) {
      amount = double.tryParse(amountRaw) ?? 0.0;
    } else {
      amount = 0.0;
    }
    id = json['id'];
    createdAt = json['created_at'];
    orderSn = json['order_sn'];
    remark = json['remark'];
    serialNo = json['serial_no'];
    sourceType = json['source_type'];
    sourceTypeName = json['source_type_name'];
    type = json['type'];
    typeName = json['type_name'];
    if (json['custom'] != null) {
      custom = CustomerModel.fromJson(json['custom']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'id': id,
      'created_at': createdAt,
      'order_sn': orderSn,
      'remark': remark,
      'serial_no': serialNo,
      'source_type': sourceType,
      'source_type_name': sourceTypeName,
      'type': type,
      'type_name': typeName,
      'custom': custom?.toJson(),
    };
  }
}
