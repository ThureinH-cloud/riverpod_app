import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static/url_const.dart';

Future<void> setupLocators() async {
  GetIt getIt = GetIt.instance;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preferences);
  Dio dio = Dio(BaseOptions(baseUrl: UrlConst.baseUrl));
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton<Dio>(dio);
}
