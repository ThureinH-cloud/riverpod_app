import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/pages/favorite_page.dart';
import 'package:riverpod_app/pages/home_page.dart';
import 'package:riverpod_app/pages/news_page.dart';
import 'package:riverpod_app/pages/price_details_page.dart';
import 'package:riverpod_app/pages/settings_page.dart';

import '../pages/price_list_page.dart';

const List<String> mainRoutes = ['/', '/favorites', '/news', '/settings'];

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) {
          return HomePage();
        }),
    GoRoute(
      name: 'list',
      path: '/list',
      builder: (context, state) {
        return PriceListPage();
      },
    ),
    GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) {
          String? symbol = state.uri.queryParameters["symbol"];
          String? name = state.uri.queryParameters["name"];
          if (symbol != null && name != null) {
            return PriceDetailsPage(symbol: symbol, name: name);
          }
          return SizedBox.shrink();
        }),
    GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) {
          return FavoritePage();
        }),
    GoRoute(
        path: '/news',
        name: 'news',
        builder: (context, state) {
          return NewsPage();
        }),
    GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) {
          return SettingsPage();
        }),
  ],
);
