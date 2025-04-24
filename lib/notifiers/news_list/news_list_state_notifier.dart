import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/data/services/news_api_services.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';

typedef NewsStateProvider
    = NotifierProvider<NewsListStateNotifier, NewsListStateModel>;

class NewsListStateNotifier extends Notifier<NewsListStateModel> {
  final NewsApiServices _newsApiServices = NewsApiServices();
  @override
  NewsListStateModel build() {
    return NewsListStateModel();
  }

  void fetchNewsfromApi() async {
    try {
      List<NewsModel> news = await _newsApiServices.getNews();
      state = state.copyWith(newsList: news);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
