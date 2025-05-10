class OrderStatisticsModel {
  late String date;
  late double num;

  OrderStatisticsModel({
    required this.date,
    required this.num,
  });

  OrderStatisticsModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];

    var numRaw = json['num'];
    if (numRaw is int) {
      num = numRaw.toDouble();
    } else if (numRaw is String) {
      num = double.parse(numRaw);
    } else {
      num = 0;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'num': num,
    };
  }
}
