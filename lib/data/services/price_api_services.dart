import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_app/data/models/price_model.dart';
import 'package:riverpod_app/static/url_const.dart';
import 'package:riverpod_app/static/utils.dart';

class PriceApiServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: UrlConst.baseUrl))
    ..interceptors.add(
      PrettyDioLogger(),
    );
  Future<List<PriceModel>> getPriceList(
      {String currency = 'usd', required int page, String? order}) async {
    Map<String, String>? orderMap = order == null ? null : {'order': order};
    final response = await _dio.get(
      UrlConst.list,
      queryParameters: {
        'vs_currency': currency,
        'price_change_percentage': '1h,24h,7d',
        'per_page': Utils.perPage,
        'page': page,
        ...orderMap ?? {},
      },
    );
    return (response.data as List).map((e) => PriceModel.fromJson(e)).toList();
  }
}
