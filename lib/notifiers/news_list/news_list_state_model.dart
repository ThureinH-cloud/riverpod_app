import 'package:riverpod_app/data/models/news_model.dart';

class NewsListStateModel {
  final NewsModel? newsModel;
  final bool loading;
  final bool success;
  final String? errorMessage;

  NewsListStateModel({
    this.newsModel,
    this.loading = false,
    this.success = false,
    this.errorMessage = '',
  });
  NewsListStateModel copyWith({
   NewsModel? newsModel,
    bool? loading,
    bool? success,
    String? errorMessage,
  }) {
    return NewsListStateModel(
      newsModel: newsModel ?? this.newsModel,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
