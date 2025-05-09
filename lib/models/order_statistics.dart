class OrderStatistics {
  late String? orderIncome;
  late int? orderIncomeGrowthRate;
  late String? orderItemsCost;
  late int? orderItemsCostGrowthRate;
  late String? orderLogisticsCost;
  late int? orderLogisticsCostGrowthRate;
  late String? orderProfit;
  late int? orderProfitGrowthRate;

  OrderStatistics({
    this.orderIncome,
    this.orderIncomeGrowthRate,
    this.orderItemsCost,
    this.orderItemsCostGrowthRate,
    this.orderLogisticsCost,
    this.orderLogisticsCostGrowthRate,
    this.orderProfit,
    this.orderProfitGrowthRate,
  });

  factory OrderStatistics.fromJson(Map<String, dynamic> json) {
    return OrderStatistics(
      orderIncome: json['order_income'],
      orderIncomeGrowthRate: json['order_income_growth_rate'],
      orderItemsCost: json['order_items_cost'],
      orderItemsCostGrowthRate: json['order_items_cost_growth_rate'],
      orderLogisticsCost: json['order_logistics_cost'],
      orderLogisticsCostGrowthRate: json['order_logistics_cost_growth_rate'],
      orderProfit: json['order_profit'],
      orderProfitGrowthRate: json['order_profit_growth_rate'],
    );
  }
}
