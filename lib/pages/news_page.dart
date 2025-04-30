import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/news_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_model.dart';
import 'package:riverpod_app/notifiers/news_list/news_list_state_notifier.dart';
import 'package:riverpod_app/pages/app_browser_page.dart';
import 'package:share_plus/share_plus.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

final newsListProvider = NewsStateProvider(
  () {
    return NewsListStateNotifier();
  },
);

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsListProvider.notifier).fetchNewsfromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    NewsListStateModel newsListStateModel = ref.watch(newsListProvider);
    NewsModel? news = newsListStateModel.newsModel;
    int count = news?.articles?.length ?? 0;
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
              itemCount: (count + 1),
              itemBuilder: (context, index) {
                print('$index -- $count');
                if (index == count) {
                  ref.read(newsListProvider.notifier).loadMore();
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                Articles? articles = news?.articles?[index];

                DateTime parsed =
                    DateTime.parse(articles?.publishedAt ?? '').toLocal();
                String year = parsed.year.toString();
                String month = parsed.month.toString().padLeft(2, '0');
                String day = parsed.day.toString().padLeft(2, '0');
                return InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            AppBrowserPage(url: articles?.url ?? ''),
                      ),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (articles?.urlToImage != null)
                                    Stack(
                                      children: [
                                        Image.network(
                                          articles?.urlToImage ?? '',
                                          width: double.infinity,
                                          height: 180,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return SizedBox.shrink();
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          color: Colors.black.withAlpha(80),
                                          margin: EdgeInsets.all(8),
                                          child: Text(
                                            articles?.source?.name ?? '',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          articles?.title ?? '',
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
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
                                                articles?.author ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          articles?.description ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Published At - $year-$month-$day'),
                                            IconButton(
                                                onPressed: () {
                                                  SharePlus.instance.share(
                                                    ShareParams(
                                                      uri: Uri.parse(
                                                        articles?.url ?? '',
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.share))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
