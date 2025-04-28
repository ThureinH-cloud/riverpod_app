import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/detail_model.dart';
import 'package:riverpod_app/data/wss/detail_wss_service.dart';
import 'package:riverpod_app/notifiers/price_details/price_detail_state_model.dart';

import '../../static/url_const.dart';

typedef PriceDetailProvider = AutoDisposeNotifierProvider<
    PriceDetailStateNotifier, PriceDetailStateModel>;

class PriceDetailStateNotifier
    extends AutoDisposeNotifier<PriceDetailStateModel> {
  final DetailWssService _detailWssService = DetailWssService();
  @override
  PriceDetailStateModel build() {
    // TODO: implement build
    _detailWssService.connect();
    ref.onDispose(() {
      _detailWssService.disconnect();
    });
    return PriceDetailStateModel();
  }

  void getUpdatedPrice(String symbol, String name) {
    _detailWssService.sendMessage(UrlConst.getWssMessage(symbol));
    Stream<DetailsModel>? detailStream = _detailWssService.getUpdatedPrice();
    detailStream?.listen(
      (price) {
        state = state.copyWith(
          currentPrice: num.tryParse(price.price ?? ''),
          bidPrice: num.tryParse(price.bestBid ?? ''),
          sellPrice: num.tryParse(price.bestAsk ?? ''),
          time: DateTime.tryParse(price.time ?? ''),
        );
      },
    ).onError((e) {
      print('error $e');
    });
  }
}
