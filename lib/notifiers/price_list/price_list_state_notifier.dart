import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/price_model.dart';
import 'package:riverpod_app/data/services/price_api_services.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_model.dart';

typedef PriceListStateProvider
    = NotifierProvider<PriceListStateNotifier, PriceListStateModel>;

class PriceListStateNotifier extends Notifier<PriceListStateModel> {
  final PriceApiServices _apiServices = PriceApiServices();
  final int _page = 1;

  @override
  PriceListStateModel build() {
    // TODO: implement build
    return PriceListStateModel();
  }

  Future<void> getPriceList({
    String? volumeSort,
    String? marketSort,
  }) async {
    try {
      state = state.copyWith(loading: true, errorMessage: '', success: false);
      List<PriceModel> priceList = await _apiServices.getPriceList(
          page: _page, order: volumeSort ?? marketSort);
      state =
          state.copyWith(priceList: priceList, success: true, loading: false);
    } catch (e) {
      state = state.copyWith(
        success: false,
        loading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
