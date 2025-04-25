import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/static/go_routes.dart';
import 'package:riverpod_app/static/my_preferences_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyPreferencesStorage.initStorage();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routers,
    );
  }
}
