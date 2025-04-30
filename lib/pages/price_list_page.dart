import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/data/models/price_model.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_model.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_notifier.dart';

import '../widgets/price_list_widget.dart';

class PriceListPage extends ConsumerStatefulWidget {
  const PriceListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PriceListPageState();
}

class _PriceListPageState extends ConsumerState<PriceListPage> {
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
    return PriceListWidget(
        stateModel: stateModel, priceList: priceList, textTheme: textTheme);
  }
}
