import 'package:riverpod_app/data/models/price_model.dart';

class PriceListStateModel {
  final List<PriceModel> priceList;
  final bool loading;
  final bool success;
  final String? errorMessage;
  PriceListStateModel({
    this.priceList = const [],
    this.loading = true,
    this.success = false,
    this.errorMessage,
  });
  PriceListStateModel copyWith(
      {List<PriceModel>? priceList,
      bool? loading,
      bool? success,
      String? errorMessage}) {
    return PriceListStateModel(
        priceList: priceList ?? this.priceList,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
