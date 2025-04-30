import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_app/notifiers/price_details/price_detail_state_model.dart';
import 'package:riverpod_app/notifiers/price_details/price_detail_state_notifier.dart';

import '../static/favorite_utils.dart';
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
  PriceDetailProvider priceDetailProvider = PriceDetailProvider(
    () {
      return PriceDetailStateNotifier();
    },
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(priceDetailProvider.notifier)
          .getUpdatedPrice(widget.symbol.toUpperCase(), widget.name);
      ref.read(priceDetailProvider.notifier).getFavoriteState(widget.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String chartUrl =
        '${UrlConst.chartUrl}${widget.symbol.toUpperCase()}USD${UrlConst.chartQuery}';

    SharedPreUtils sharedPreUtils = GetIt.I.get<SharedPreUtils>();
    print(sharedPreUtils.getFavorite());
    //sharedPreUtils.clearFavorite();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.name),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              bool favorite =
                  ref.watch(priceDetailProvider).isFavorite ?? false;
              return IconButton(
                onPressed: () {
                  if (favorite) {
                    ref
                        .read(priceDetailProvider.notifier)
                        .removeFavorite(widget.name);
                  } else {
                    ref
                        .read(priceDetailProvider.notifier)
                        .addFavorite(widget.name);
                  }
                  {}
                },
                icon: favorite ? Icon(Icons.star) : Icon(Icons.star_outline),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.4,
              child: IframeViewer(link: chartUrl),
            ),
            Consumer(
              builder: (context, ref, child) {
                PriceDetailStateModel model = ref.watch(priceDetailProvider);
                return Column(
                  spacing: 23,
                  children: [
                    Row(
                      children: [
                        Text("Current Price -"),
                        Text(model.currentPrice.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Bid Price -"),
                        Text(model.bidPrice.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Sell Price -"),
                        Text(model.sellPrice.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Time -"),
                        Text(model.time.toString()),
                      ],
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
