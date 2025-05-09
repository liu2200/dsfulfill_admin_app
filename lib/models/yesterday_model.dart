class YesterdayModel {
  late int costAmount;
  late int createDate;
  late int incomeAmount;
  late int profit;
  late int totalOrder;

  YesterdayModel({
    required this.costAmount,
    required this.createDate,
    required this.incomeAmount,
    required this.profit,
    required this.totalOrder,
  });

  YesterdayModel.fromJson(Map<String, dynamic> json) {
    if (json['create_date'] != null) {
      createDate = json['create_date'];
    }
    if (json['income_amount'] != null) {
      incomeAmount = json['income_amount'];
    }
    if (json['profit'] != null) {
      profit = json['profit'];
    }
    if (json['total_order'] != null) {
      totalOrder = json['total_order'];
    }
    if (json['cost_amount'] != null) {
      costAmount = json['cost_amount'];
    }
  }
}
