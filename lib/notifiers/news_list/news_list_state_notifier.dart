import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/services/news_api_services.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';

class NewsListStateNotifier extends Notifier<NewsListStateModel> {
  final NewsApiServices _newsApiServices = NewsApiServices();
  @override
  NewsListStateModel build() {
    return NewsListStateModel();
  }

  void fetchNewsfromApi() {
    print(_newsApiServices.getNews());
  }
}
