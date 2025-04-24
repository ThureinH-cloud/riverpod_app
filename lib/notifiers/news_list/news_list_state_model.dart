import 'package:riverpod_app/data/models/news_model.dart';

class NewsListStateModel {
  final List<NewsModel> newsList;
  final bool loading;
  final bool success;
  final String? errorMessage;

  NewsListStateModel({
    this.newsList = const [],
    this.loading = false,
    this.success = false,
    this.errorMessage = '',
  });
  NewsListStateModel copyWith({
    List<NewsModel>? newsList,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return NewsListStateModel(
      newsList: newsList ?? this.newsList,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
