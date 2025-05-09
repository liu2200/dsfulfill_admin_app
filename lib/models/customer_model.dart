class CustomerModel {
  late int id;
  late double balance;
  late String customName;
  late String consumeAmount;
  late String creditLine;
  late String customEmail;
  late String customPhone;
  late String groupName;
  late String phoneAreaCode;
  late String residualCredit;
  late String lastLoginTime;
  late String createdAt;
  late String staffName;
  late int groupId;
  late int isAutoPayment;
  late int commissionRate;
  late String commissionAmount;
  late String defaultLanguage;

  CustomerModel({
    required this.id,
    required this.customName,
    required this.balance,
    required this.consumeAmount,
    required this.creditLine,
    required this.customEmail,
    required this.customPhone,
    required this.groupName,
    required this.phoneAreaCode,
    required this.residualCredit,
    required this.lastLoginTime,
    required this.createdAt,
    required this.staffName,
    required this.isAutoPayment,
    required this.groupId,
    required this.commissionRate,
    required this.commissionAmount,
    required this.defaultLanguage,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customName = json['custom_name'];
    var balanceRaw = json['balance'];
    if (balanceRaw is int) {
      balance = balanceRaw.toDouble();
    } else if (balanceRaw is double) {
      balance = balanceRaw;
    } else if (balanceRaw is String) {
      balance = double.tryParse(balanceRaw) ?? 0.0;
    } else {
      balance = 0.0;
    }
    if (json['consume_amount'] != null) {
      consumeAmount = json['consume_amount'];
    }
    var creditLineRaw = json['credit_line'];
    if (creditLineRaw is int) {
      creditLine = creditLineRaw.toString();
    } else {
      creditLine = json['credit_line'];
    }
    if (json['custom_email'] != null) {
      customEmail = json['custom_email'] as String;
    }
    if (json['custom_phone'] != null) {
      customPhone = json['custom_phone'];
    }
    if (json['group_name'] != null) {
      groupName = json['group_name'];
    }
    if (json['phone_area_code'] != null) {
      phoneAreaCode = json['phone_area_code'];
    }
    var residualCreditRaw = json['credit_line'];
    if (residualCreditRaw is int) {
      residualCredit = residualCreditRaw.toString();
    } else {
      residualCredit = json['residual_credit'];
    }
    if (json['last_login_at'] != null) {
      lastLoginTime = json['last_login_at'];
    }
    if (json['created_at'] != null) {
      createdAt = json['created_at'];
    }
    if (json['staff_name'] != null) {
      staffName = json['staff_name'];
    }
    if (json['is_auto_payment'] != null) {
      isAutoPayment = json['is_auto_payment'];
    }
    if (json['group_id'] != null) {
      groupId = json['group_id'];
    }
    if (json['commission_rate'] != null) {
      commissionRate = json['commission_rate'];
    }
    if (json['commission_amount'] != null) {
      commissionAmount = json['commission_amount'];
    }
    if (json['default_language'] != null) {
      defaultLanguage = json['default_language'];
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'custom_name': customName,
      'balance': balance,
      'consume_amount': consumeAmount,
      'credit_line': creditLine,
      'custom_email': customEmail,
      'custom_phone': customPhone,
      'group_name': groupName,
      'phone_area_code': phoneAreaCode,
      'residual_credit': residualCredit,
      'last_login_at': lastLoginTime,
      'created_at': createdAt,
      'staff_name': staffName,
      'is_auto_payment': isAutoPayment,
      'group_id': groupId,
      'commission_rate': commissionRate,
      'commission_amount': commissionAmount,
      'default_language': defaultLanguage,
    };
  }
}
