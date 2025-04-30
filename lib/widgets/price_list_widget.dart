import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/models/price_model.dart';
import '../notifiers/price_list/price_list_state_model.dart';
import '../static/number_format.dart';
import 'price_indicator.dart';

class PriceListWidget extends StatelessWidget {
  const PriceListWidget({
    super.key,
    required this.stateModel,
    required this.priceList,
    required this.textTheme,
  });

  final PriceListStateModel stateModel;
  final List<PriceModel> priceList;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                return InkWell(
                  onTap: () {
                    String? symbol = priceModel.symbol;
                    if (symbol != null) {
                      context.pushNamed(
                        'detail',
                        queryParameters: {
                          'symbol': symbol,
                          'name': priceModel.name ?? '',
                        },
                      );
                    }
                  },
                  child: Card(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('1h'),
                            ),
                            Expanded(
                              child: Text('24h'),
                            ),
                            Expanded(
                              child: Text('7d'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  priceIndicator(priceModel
                                          .priceChangePercentage1hInCurrency ??
                                      0),
                                  Text(
                                    priceModel.priceChangePercentage1hInCurrency
                                            ?.toStringAsFixed(1) ??
                                        '',
                                    style: TextStyle(
                                      color: indicatorColor(priceModel
                                              .priceChangePercentage1hInCurrency ??
                                          0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  priceIndicator(priceModel
                                          .priceChangePercentage24hInCurrency ??
                                      0),
                                  Text(
                                    priceModel
                                            .priceChangePercentage24hInCurrency
                                            ?.toStringAsFixed(1) ??
                                        '',
                                    style: TextStyle(
                                      color: indicatorColor(priceModel
                                              .priceChangePercentage24hInCurrency ??
                                          0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  priceIndicator(priceModel
                                          .priceChangePercentage7dInCurrency ??
                                      0),
                                  Text(
                                    priceModel.priceChangePercentage7dInCurrency
                                            ?.toStringAsFixed(1) ??
                                        '',
                                    style: TextStyle(
                                      color: indicatorColor(priceModel
                                              .priceChangePercentage7dInCurrency ??
                                          0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text('24 hr volume'),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('Market Cap'),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                  ' ${NumberUtils.commaDecimal(priceModel.totalVolume ?? 0, 2)}'),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  NumberUtils.commaDecimal(
                                      priceModel.marketCap ?? 0, 2),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
