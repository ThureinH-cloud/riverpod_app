import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_app/notifiers/app_state/app_state_model.dart';
import 'package:riverpod_app/static/favorite_utils.dart';

typedef AppStateProvider = NotifierProvider<AppStateNotifier, AppStateModel>;

class AppStateNotifier extends Notifier<AppStateModel> {
  final SharedPreUtils _preUtils = GetIt.I.get<SharedPreUtils>();
  @override
  AppStateModel build() {
    // TODO: implement build
    final bool isDark = _preUtils.getTheme();
    return AppStateModel(isDark: isDark);
  }

  void toggleDarkMode(bool mode) {
    _preUtils.saveTheme(mode);
    state = AppStateModel(isDark: mode);
  }
}
