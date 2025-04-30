import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_app/notifiers/app_state/app_state_notifier.dart';
import 'package:riverpod_app/static/favorite_utils.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final AppStateProvider _appStateProvider = GetIt.I.get<AppStateProvider>();
  final SharedPreUtils _preUtils = GetIt.I.get<SharedPreUtils>();
  @override
  Widget build(BuildContext context) {
    bool mode = ref.watch(_appStateProvider).isDark;
    return SafeArea(
      child: Column(
        children: [
          Card(
            child: SwitchListTile.adaptive(
              title: const Text("Dark Mode"),
              value: mode,
              onChanged: (value) {
                ref.read(_appStateProvider.notifier).toggleDarkMode(value);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delete),
              title: Text("Remove Favorites"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text("Remove Favorites"),
                        content: Text(
                            "Are you sure you want to remove all favorites?"),
                        actions: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          if (Platform.isIOS)
                            TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    WidgetStatePropertyAll(Colors.transparent),
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.red),
                              ),
                              onPressed: () {
                                _preUtils.clearFavorite();
                                Navigator.pop(context);
                              },
                              child: Text("Remove"),
                            ),
                          if (Platform.isAndroid)
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Remove"),
                            ),
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
