import 'package:eventgo/core/enums/local_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalManager {
  SharedPreferences? _sharedPreferences;
  LocalManager._init() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }
  static final _instance = LocalManager._init();
  static LocalManager get instance => _instance;

  static Future preferencesInit() async {
    _instance._sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _sharedPreferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_sharedPreferences != null) {
      await _sharedPreferences!.clear();
      await setBoolValue(PreferencesKeys.IS_FIRST_APP, false);
    }
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _sharedPreferences!.setString(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _sharedPreferences!.setBool(key.toString(), value);
  }

  Future<void> setIntValue(PreferencesKeys key, int value) async {
    await _sharedPreferences!.setInt(key.toString(), value);
  }

  int getIntValue(PreferencesKeys key) =>
      _sharedPreferences?.getInt(key.toString()) ?? 0;

  String getStringValue(PreferencesKeys key) =>
      _sharedPreferences?.getString(key.toString()) ?? '';

  bool getBoolValue(PreferencesKeys key) =>
      _sharedPreferences?.getBool(key.toString()) ?? true;
}
