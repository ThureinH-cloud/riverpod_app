import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/price_model.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_model.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_notifier.dart';

class PriceListPage extends ConsumerStatefulWidget {
  const PriceListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceListPageState();
}

class _PriceListPageState extends ConsumerState<PriceListPage> {
  bool volume_sort = false;
  bool market_cap_sort = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(priceListProvider.notifier).getPriceList();
    });
  }

  final priceListProvider = PriceListStateProvider(
    () {
      return PriceListStateNotifier();
    },
  );
  @override
  Widget build(BuildContext context) {
    PriceListStateModel stateModel = ref.watch(priceListProvider);
    List<PriceModel> priceList = stateModel.priceList;
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cryptocurrency Price List"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    volume_sort = !volume_sort;
                    market_cap_sort = false;
                  });
                  if (volume_sort) {
                    ref
                        .read(priceListProvider.notifier)
                        .getPriceList(volumeSort: "volume_desc");
                  } else {
                    ref
                        .read(priceListProvider.notifier)
                        .getPriceList(volumeSort: "volume_asc");
                  }
                },
                label: Row(
                  children: [
                    Icon(volume_sort
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                    Text('24 Hour Volume'),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    market_cap_sort = !market_cap_sort;
                    volume_sort = false;
                  });
                  if (market_cap_sort) {
                    ref
                        .read(priceListProvider.notifier)
                        .getPriceList(volumeSort: "market_cap_desc");
                  } else {
                    ref
                        .read(priceListProvider.notifier)
                        .getPriceList(volumeSort: "market_cap_asc");
                  }
                },
                label: Row(
                  children: [
                    Icon(market_cap_sort
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                    Text('Market Cap'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (stateModel.loading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (stateModel.success && !stateModel.loading)
            Expanded(
              child: ListView.builder(
                itemCount: priceList.length,
                itemBuilder: (context, index) {
                  PriceModel priceModel = priceList[index];
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  if (priceModel.image != null)
                                    Image.network(
                                      priceModel.image!,
                                      width: 30,
                                      height: 30,
                                    ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Flexible(
                                    child: Text(
                                      maxLines: 1,
                                      priceModel.name ?? '',
                                      style: textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                priceModel.symbol?.toUpperCase() ?? '',
                                style: textTheme.bodyLarge,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '\$ ${priceModel.currentPrice?.toStringAsFixed(2) ?? ""}  ',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('1h'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('24h'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('7d'),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text('24 hr volume'),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text('Market Cap'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(priceModel
                                      .priceChangePercentage1hInCurrency
                                      ?.toStringAsFixed(1) ??
                                  ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(priceModel
                                      .priceChangePercentage24hInCurrency
                                      ?.toStringAsFixed(1) ??
                                  ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(priceModel
                                      .priceChangePercentage7dInCurrency
                                      ?.toStringAsFixed(1) ??
                                  ''),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                priceModel.totalVolume.toString(),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                priceModel.marketCap.toString(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
