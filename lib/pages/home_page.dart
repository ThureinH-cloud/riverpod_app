import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/pages/favorite_page.dart';
import 'package:riverpod_app/pages/price_list_page.dart';
import 'package:riverpod_app/pages/settings_page.dart';
import 'package:riverpod_app/static/go_routes.dart';

import 'news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GoRouterState state = GoRouter.of(context).state;
    String path = state.uri.path;
    print(path);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cryptocurrency Price List"),
        actions: [],
      ),
      body: Column(
        children: [
          if (path == '/')
            Expanded(
              child: PriceListPage(),
            ),
          if (path == '/favorites')
            Expanded(
              child: FavoritePage(),
            ),
          if (path == '/news')
            Expanded(
              child: NewsPage(),
            ),
          if (path == '/settings')
            Expanded(
              child: SettingsPage(),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(path),
        onDestinationSelected: (index) {
          context.go(mainRoutes[index]);
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Favorite'),
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/favorites')) return 1;
    if (location.startsWith('/news')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }
}
