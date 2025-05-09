class OrderStatisticsModel {
  late String date;
  late int num;

  OrderStatisticsModel({
    required this.date,
    required this.num,
  });

  OrderStatisticsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'num': num,
    };
  }
}
