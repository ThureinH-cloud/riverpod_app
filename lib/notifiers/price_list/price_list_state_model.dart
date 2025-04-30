import 'package:riverpod_app/data/models/price_model.dart';

class PriceListStateModel {
  final List<PriceModel> priceList;
  final List<PriceModel> favList;
  final bool loading;
  final bool success;
  final String? errorMessage;
  PriceListStateModel(
      {this.priceList = const [],
      this.loading = true,
      this.success = false,
      this.errorMessage,
      this.favList = const []});
  PriceListStateModel copyWith(
      {List<PriceModel>? priceList,
      bool? loading,
      bool? success,
      String? errorMessage,
      List<PriceModel>? favList}) {
    return PriceListStateModel(
      priceList: priceList ?? this.priceList,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      favList: favList ?? this.favList,
    );
  }
}
