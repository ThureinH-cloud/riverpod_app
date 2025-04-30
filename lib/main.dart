import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_app/di/locators.dart';
import 'package:riverpod_app/notifiers/app_state/app_state_notifier.dart';
import 'package:riverpod_app/static/favorite_utils.dart';
import 'package:riverpod_app/static/go_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocators();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppStateProvider _appStateProvider = AppStateProvider(
    () {
      return AppStateNotifier();
    },
  );
  final SharedPreUtils _sharedPreUtils = GetIt.I.get<SharedPreUtils>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetIt.I.registerSingleton(_appStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    bool mode = ref.watch(_appStateProvider).isDark;
    return MaterialApp.router(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: routers,
    );
  }
}
