import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
