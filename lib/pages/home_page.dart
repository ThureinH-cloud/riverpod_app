import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/notifiers/price_details/price_detail_state_notifier.dart';
import 'package:riverpod_app/notifiers/price_list/price_list_state_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final priceListProvider = PriceListStateProvider(
    () => PriceListStateNotifier(),
  );
  final priceDetailProvider = PriceDetailProvider(
    () => PriceDetailStateNotifier(),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!GetIt.I.isRegistered<PriceListStateProvider>()) {
      GetIt.I.registerSingleton<PriceListStateProvider>(priceListProvider);
    }
    if (!GetIt.I.isRegistered<PriceDetailProvider>()) {
      GetIt.I.registerSingleton<PriceDetailProvider>(priceDetailProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final currentPath = GoRouter.of(context).state.uri.path;
    // final selectedIndex = mainRoutes.indexOf(currentPath);
    StatefulNavigationShell shell = widget.shell;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Cryptocurrency App"),
      // ),
      body: Column(
        children: [
          Expanded(
            child: shell,
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) {
          shell.goBranch(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
