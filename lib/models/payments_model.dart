class PaymentsModel {
  late int id;
  late String name;
  late String payLogo;
  late String currency;
  List<PaymentSettingConnection>? paymentSettingConnection;

  PaymentsModel({
    required this.id,
    required this.name,
    required this.payLogo,
    required this.currency,
    this.paymentSettingConnection,
  });

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    payLogo = json['pay_logo'];
    currency = json['currency'];
    if (json['payment_setting_connection'] != null) {
      paymentSettingConnection = [];
      json['payment_setting_connection'].forEach((v) {
        paymentSettingConnection!.add(PaymentSettingConnection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pay_logo': payLogo,
      'currency': currency,
      'payment_setting_connection':
          paymentSettingConnection?.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentSettingConnection {
  late int id;
  late String name;
  late String content;

  PaymentSettingConnection({
    required this.id,
    required this.name,
    required this.content,
  });

  PaymentSettingConnection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
    };
  }
}
