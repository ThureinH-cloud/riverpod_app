import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/pages/price_details_page.dart';

import '../pages/favorite_page.dart';
import '../pages/home_page.dart';
import '../pages/news_page.dart';
import '../pages/price_list_page.dart';
import '../pages/settings_page.dart';

const mainRoutes = [
  '/',
  '/favorites',
  '/news',
  '/settings',
];

final GoRouter routers = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(child: PriceListPage()),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => HomePage(child: FavoritePage()),
    ),
    GoRoute(
      path: '/news',
      builder: (context, state) => HomePage(child: NewsPage()),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => HomePage(child: SettingsPage()),
    ),
    GoRoute(
        name: 'detail',
        path: '/detail',
        builder: (context, state) {
          String? symbol = state.uri.queryParameters['symbol'];
          String? name = state.uri.queryParameters['name'];
          if (symbol != null && name != null) {
            return PriceDetailsPage(symbol: symbol, name: name);
          }
          return SizedBox.shrink();
        }),
  ],
);
