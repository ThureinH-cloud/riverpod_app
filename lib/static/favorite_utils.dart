import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreUtils {
  final String _favKey = "fav";
  final String _themeKey = "theme";
  final SharedPreferences _sharedPreferences = GetIt.I.get<SharedPreferences>();
  void saveFavorite(String code) {
    List<String> existingCodes = getFavorite();
    _sharedPreferences
        .setStringList(_favKey, [...existingCodes, code.toLowerCase()]);
  }

  bool isFavorite(String code) {
    List<String> existingCodes = getFavorite();
    return existingCodes.contains(code.toLowerCase());
  }

  void removeFavorite(String code) {
    List<String> existingCodes = getFavorite();
    existingCodes.remove(code.toLowerCase());
    _sharedPreferences.setStringList(_favKey, existingCodes);
  }

  void clearFavorite() {
    _sharedPreferences.setStringList(_favKey, []);
  }

  void saveTheme(bool isDark) {
    _sharedPreferences.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return _sharedPreferences.getBool(_themeKey) ?? false;
  }

  List<String> getFavorite() {
    return _sharedPreferences.getStringList(_favKey) ?? [];
  }
}
