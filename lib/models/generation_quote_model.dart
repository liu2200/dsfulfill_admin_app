class GenerationQuoteModel {
  int? expressLineId;
  int? expressCompaniesAgentId;
  String? favourableComputePrice;
  String? favourablePrice;
  String? goodsPrice;
  String? logisticsComputeFee;
  String? logisticsFee;
  int? logisticsProvider;
  String? logisticsProviderCode;
  String? originLogisticsFee;
  String? otherSupplementPrice;
  String? totalPrice;
  int? useCustomerStock;
  List<ChannelListModel>? channelList;

  GenerationQuoteModel({
    this.expressLineId,
    this.expressCompaniesAgentId,
    this.favourableComputePrice,
    this.favourablePrice,
    this.goodsPrice,
    this.logisticsComputeFee,
    this.logisticsFee,
    this.logisticsProvider,
    this.logisticsProviderCode,
    this.originLogisticsFee,
    this.otherSupplementPrice,
    this.totalPrice,
    this.useCustomerStock,
    this.channelList,
  });

  GenerationQuoteModel.fromJson(Map<String, dynamic> json) {
    expressLineId = json['express_line_id'];
    expressCompaniesAgentId = json['express_companies_agent_id'];
    favourableComputePrice = json['favourable_compute_price'];
    favourablePrice = json['favourable_price'];
    goodsPrice = json['goods_price'];
    logisticsComputeFee = json['logistics_compute_fee'];
    logisticsFee = json['logistics_fee'];
    logisticsProvider = json['logistics_provider'];
    logisticsProviderCode = json['logistics_provider_code'];
    originLogisticsFee = json['origin_logistics_fee'];
    otherSupplementPrice = '0.00';
    if (json['other_supplement_price'] != null) {
      otherSupplementPrice = json['other_supplement_price'];
    }
    totalPrice = json['total_price'];
    useCustomerStock = json['use_customer_stock'];
    if (json['channel_list'] != null && json['channel_list'] is List) {
      channelList = [];
      json['channel_list'].forEach((v) {
        channelList!.add(ChannelListModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'express_line_id': expressLineId,
      'express_companies_agent_id': expressCompaniesAgentId,
      'favourable_compute_price': favourableComputePrice,
      'favourable_price': favourablePrice,
      'goods_price': goodsPrice,
      'logistics_compute_fee': logisticsComputeFee,
      'logistics_fee': logisticsFee,
      'logistics_provider': logisticsProvider,
      'logistics_provider_code': logisticsProviderCode,
      'origin_logistics_fee': originLogisticsFee,
      'other_supplement_price': otherSupplementPrice,
      'total_price': totalPrice,
      'use_customer_stock': useCustomerStock,
      'channel_list': channelList?.map((e) => e.toJson()).toList(),
    };
  }
}

class ChannelListModel {
  int? id;
  String? name;

  ChannelListModel({
    this.id,
    this.name,
  });

  ChannelListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
