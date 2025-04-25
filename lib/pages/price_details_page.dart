import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/static/my_preferences_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../static/url_const.dart';
import '../widgets/iframe_viewer/iframe_viewer_mobile.dart';

class PriceDetailsPage extends ConsumerStatefulWidget {
  const PriceDetailsPage({super.key, required this.name, required this.symbol});
  final String symbol;
  final String name;

  @override
  ConsumerState<PriceDetailsPage> createState() => _PriceDetailsPageState();
}

class _PriceDetailsPageState extends ConsumerState<PriceDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String chartUrl =
        '${UrlConst.chartUrl}${widget.symbol.toUpperCase()}USD${UrlConst.chartQuery}';
    print(chartUrl);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: () async {
              Set<String> list = MyPreferencesStorage.getFavList().toSet();
              list.add(widget.name);
              SharedPreferences myPrefs = MyPreferencesStorage.getPreferences();
              myPrefs.setStringList("favorites", list.toList());
              print(myPrefs.getStringList("favorites"));
            },
            icon: Icon(
              Icons.favorite_outline,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.4,
              child: IframeViewer(link: chartUrl),
            ),
          ],
        ),
      ),
    );
  }
}
