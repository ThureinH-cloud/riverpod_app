import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  static const mainRoutes = [
    '/',
    '/favorites',
    '/news',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).state.uri.path;
    final selectedIndex = mainRoutes.indexOf(currentPath);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cryptocurrency App"),
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onDestinationSelected: (index) {
          context.go(mainRoutes[index]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Favorite'),
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
