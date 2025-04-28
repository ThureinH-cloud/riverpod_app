import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/pages/home_page.dart';
import 'package:riverpod_app/pages/price_details_page.dart';

import '../pages/favorite_page.dart';
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'list',
              path: '/',
              builder: (context, state) => PriceListPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'favorites',
              path: '/favorites',
              builder: (context, state) => FavoritePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'news',
              path: '/news',
              builder: (context, state) => NewsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'settings',
              path: '/settings',
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
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
