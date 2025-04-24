import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("News"),
        ),
        TextButton(onPressed: () {}, child: Text("Get News"))
      ],
    );
  }
}
