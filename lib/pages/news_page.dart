import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_notifier.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsListProvider.notifier).fetchNewsfromApi();
    });
  }

  final newsListProvider = NewsStateProvider(
    () {
      return NewsListStateNotifier();
    },
  );
  @override
  Widget build(BuildContext context) {
    NewsListStateModel newsListStateModel = ref.watch(newsListProvider);
    List<NewsModel> news = newsListStateModel.newsList;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              NewsModel newsModel = news[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        newsModel.urlToImage ?? '',
                        width: 140,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            newsModel.title?.substring(0, 20) ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(newsModel.publishedAt ?? ''),
                          Row(
                            children: [
                              Text('Author - '),
                              Text(newsModel.author?.substring(0, 9) ?? ''),
                            ],
                          ),
                          Text(
                            newsModel.description?.substring(0, 17) ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(newsModel.content?.substring(0, 22) ?? '')
                        ],
                      )
                    ],
                  ),
                  Divider()
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
