import 'package:riverpod_app/static/my_preferences_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteDto {
  static SharedPreferences preferences = MyPreferencesStorage.getPreferences();
  static void setFavoriteList(List<String> prices) {
    preferences.setStringList("favorites", prices);
  }

  static List<String> getFavList() {
    return preferences.getStringList('favorites') ?? [];
  }
}
