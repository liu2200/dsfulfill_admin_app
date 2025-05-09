import 'package:dsfulfill_cient_app/models/customer_model.dart';

class RechargeModel {
  late int id;
  late String currency;
  late int applyAmount;
  late int applyOperator;
  late String payAccount;
  late int status;
  late String statusName;
  late String serialNo;
  late double payAmount;
  late String revocationRemark;
  late String createdAt;
  late int paymentTypeId;
  late String confirmRemark;
  late double confirmAmount;
  List<String>? applyImages;
  List<String>? confirmImages;
  CustomerModel? custom;

  RechargeModel({
    required this.id,
    required this.currency,
    required this.applyAmount,
    required this.applyOperator,
    required this.payAccount,
    required this.status,
    required this.statusName,
    required this.serialNo,
    required this.payAmount,
    required this.revocationRemark,
    required this.createdAt,
    required this.paymentTypeId,
    required this.confirmRemark,
    required this.confirmAmount,
    this.applyImages,
    this.confirmImages,
    this.custom,
  });

  RechargeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    applyAmount = json['apply_amount'];
    if (json['apply_operator'] != null) {
      applyOperator = json['apply_operator'];
    }
    payAccount = json['pay_account'];
    status = json['status'];
    statusName = json['status_name'];
    serialNo = json['serial_no'];
    var payAmountRaw = json['pay_amount'];
    if (payAmountRaw is int) {
      payAmount = payAmountRaw.toDouble();
    } else if (payAmountRaw is double) {
      payAmount = payAmountRaw;
    } else if (payAmountRaw is String) {
      payAmount = double.tryParse(payAmountRaw) ?? 0.0;
    } else {
      payAmount = 0.0;
    }
    var confirmAmountRaw = json['confirm_amount'];
    if (confirmAmountRaw is int) {
      confirmAmount = confirmAmountRaw.toDouble();
    } else if (confirmAmountRaw is double) {
      confirmAmount = confirmAmountRaw;
    } else if (confirmAmountRaw is String) {
      confirmAmount = double.tryParse(confirmAmountRaw) ?? 0.0;
    } else {
      confirmAmount = 0.0;
    }
    revocationRemark = json['revocation_remark'];
    createdAt = json['created_at'];
    if (json['apply_images'] != null) {
      applyImages = [];
      for (var v in json['apply_images']) {
        if (v is String) {
          applyImages!.add(v);
        } else if (v is Map && v['url'] != null) {
          applyImages!.add(v['url'].toString());
        }
      }
    }
    if (json['confirm_images'] != null) {
      confirmImages = [];
      for (var v in json['confirm_images']) {
        if (v is String) {
          confirmImages!.add(v);
        } else if (v is Map && v['url'] != null) {
          confirmImages!.add(v['url'].toString());
        }
      }
    }
    if (json['custom'] != null) {
      custom = CustomerModel.fromJson(json['custom']);
    }
    paymentTypeId = json['payment_type_id'];
    if (json['confirm_remark'] != null) {
      confirmRemark = json['confirm_remark'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency': currency,
      'apply_amount': applyAmount,
      'apply_operator': applyOperator,
      'pay_account': payAccount,
      'status': status,
      'status_name': statusName,
      'serial_no': serialNo,
      'pay_amount': payAmount,
      'revocation_remark': revocationRemark,
      'created_at': createdAt,
      'apply_images': applyImages,
      'custom': custom?.toJson(),
      'payment_type_id': paymentTypeId,
      'confirm_remark': confirmRemark,
      'confirm_images': confirmImages,
      'confirm_amount': confirmAmount,
    };
  }
}
