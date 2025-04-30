import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
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

  final PriceListStateProvider priceListProvider =
      GetIt.I.get<PriceListStateProvider>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return PriceListWidget(
        isFav: false, stateProvider: priceListProvider, textTheme: textTheme);
  }
}
