import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/static/url_const.dart';

class NewsApiServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: UrlConst.newsUrl))
    ..interceptors.add(
      PrettyDioLogger(),
    );
  Future<List<NewsModel>> getNews() async {
    final response = await _dio.get(UrlConst.queryString);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['articles'];
      return data.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
