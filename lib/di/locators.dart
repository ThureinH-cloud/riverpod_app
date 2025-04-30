import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_app/static/favorite_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static/url_const.dart';

Future<void> setupLocators() async {
  GetIt getIt = GetIt.instance;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preferences);
  Dio dio = Dio(BaseOptions(baseUrl: UrlConst.baseUrl));
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(dio, instanceName: 'price');
  Dio dioNews = Dio(BaseOptions(baseUrl: UrlConst.newsUrl));
  dioNews.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(dioNews, instanceName: 'news');
  SharedPreUtils utils = SharedPreUtils();
  getIt.registerSingleton<SharedPreUtils>(utils);
}
