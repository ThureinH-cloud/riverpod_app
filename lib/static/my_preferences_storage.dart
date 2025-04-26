import 'package:shared_preferences/shared_preferences.dart';

class MyPreferencesStorage {
  static SharedPreferences? sharedPreferences;
  static Future<void> initStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences getPreferences() {
    return sharedPreferences!;
  }
}
