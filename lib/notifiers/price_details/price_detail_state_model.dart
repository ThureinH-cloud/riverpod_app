class PriceDetailStateModel {
  num? currentPrice;
  num? bidPrice;
  num? sellPrice;
  DateTime? time;
  PriceDetailStateModel({
    this.currentPrice,
    this.bidPrice,
    this.sellPrice,
    this.time,
  });
  PriceDetailStateModel copyWith({
    num? currentPrice,
    num? bidPrice,
    num? sellPrice,
    DateTime? time,
  }) {
    return PriceDetailStateModel(
      currentPrice: currentPrice ?? this.currentPrice,
      bidPrice: bidPrice ?? this.bidPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      time: time ?? this.time,
    );
  }
}
