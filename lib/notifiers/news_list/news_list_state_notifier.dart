import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/data/services/news_api_services.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';

typedef NewsStateProvider
    = NotifierProvider<NewsListStateNotifier, NewsListStateModel>;

class NewsListStateNotifier extends Notifier<NewsListStateModel> {
  final NewsApiServices _newsApiServices = NewsApiServices();
  int _page = 1;

  @override
  NewsListStateModel build() {
    return NewsListStateModel();
  }

  void loadMore() async {
    print("Loaded -----");
    _page = _page + 1;
    try {
      NewsModel newList = await _newsApiServices.getNews(
        page: _page,
      );
      state = state.copyWith(newsModel:state.newsModel?.copyWith(articles:[
        ...state.newsModel?.articles ?? [],
        ...newList.articles ?? []
      ] ,));
    } catch (e) {
      print(e.toString());
    }
  }

  void fetchNewsfromApi() async {
    try {
      state = state.copyWith(loading: true, errorMessage: '');
      NewsModel news = await _newsApiServices.getNews();
      state = state.copyWith(loading: false, newsModel: news);
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }
}
