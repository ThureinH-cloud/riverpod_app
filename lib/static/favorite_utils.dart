import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreUtils {
  final String _favKey = "fav";
  final SharedPreferences _sharedPreferences = GetIt.I.get<SharedPreferences>();
  void saveFavorite(String code) {
    List<String> existingCodes = getFavorite();
    _sharedPreferences
        .setStringList(_favKey, [...existingCodes, code.toUpperCase()]);
  }

  List<String> getFavorite() {
    return _sharedPreferences.getStringList(_favKey) ?? [];
  }
}
