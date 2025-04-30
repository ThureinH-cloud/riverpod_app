class PriceDetailStateModel {
  num? currentPrice;
  num? bidPrice;
  num? sellPrice;
  DateTime? time;
  bool? isFavorite;
  PriceDetailStateModel(
      {this.currentPrice,
      this.bidPrice,
      this.sellPrice,
      this.time,
      this.isFavorite});
  PriceDetailStateModel copyWith(
      {num? currentPrice,
      num? bidPrice,
      num? sellPrice,
      DateTime? time,
      bool? isFavorite}) {
    return PriceDetailStateModel(
        currentPrice: currentPrice ?? this.currentPrice,
        bidPrice: bidPrice ?? this.bidPrice,
        sellPrice: sellPrice ?? this.sellPrice,
        time: time ?? this.time,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}
