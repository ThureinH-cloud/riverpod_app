import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_notifier.dart';
import 'package:riverpod_app/pages/app_browser_page.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (newsListStateModel.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (newsListStateModel.loading == false)
          Expanded(
            child: ListView.builder(
              itemCount: news.length + 1,
              itemBuilder: (context, index) {
                if (index == news.length) {
                  ref.read(newsListProvider.notifier).loadMore();
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                NewsModel newsModel = news[index];
                DateTime parsed =
                    DateTime.parse(newsModel.publishedAt!).toLocal();
                String year = parsed.year.toString();
                String month = parsed.month.toString().padLeft(2, '0');
                String day = parsed.day.toString().padLeft(2, '0');
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            AppBrowserPage(url: newsModel.url ?? ''),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Row(
                          children: [
                            if (newsModel.urlToImage != null)
                              Image.network(
                                newsModel.urlToImage ?? '',
                                width: 120,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            if (newsModel.urlToImage == null) SizedBox.shrink(),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsModel.title ?? '',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Author - ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          newsModel.author ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    newsModel.description ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Published At - '),
                                      Text('$year-$month-$day'),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
