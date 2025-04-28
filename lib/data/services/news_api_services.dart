import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/static/url_const.dart';

class NewsApiServices {
  final Dio _dio=GetIt.instance.get(instanceName: 'news');
  Future<NewsModel> getNews({int page=1}) async {
    final response = await _dio.get(UrlConst.queryString,
        queryParameters: {"page": page, "pageSize": 20});
    return NewsModel.fromJson(response.data);
  }
}
