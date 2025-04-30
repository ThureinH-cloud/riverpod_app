import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_app/data/models/price_model.dart';
import 'package:riverpod_app/static/url_const.dart';
import 'package:riverpod_app/static/utils.dart';

class PriceApiServices {
  final Dio _dio = GetIt.instance.get<Dio>(instanceName: 'price');
  Future<List<PriceModel>> getPriceList(
      {String currency = 'usd',
      required int? page,
      String? order,
      List<String>? ids}) async {
    Map<String, String>? orderMap = order == null ? null : {'order': order};
    Map<String, int>? pageMap =
        page == null ? null : {'per_page': Utils.perPage, 'page': page};
    Map<String, String>? idParams = ids == null ? null : {'ids': ids.join(',')};
    final response = await _dio.get(
      UrlConst.list,
      queryParameters: {
        'vs_currency': currency,
        'price_change_percentage': '1h,24h,7d',
        ...idParams ?? {},
        ...pageMap ?? {},
        ...orderMap ?? {},
      },
    );
    return (response.data as List).map((e) => PriceModel.fromJson(e)).toList();
  }
}
