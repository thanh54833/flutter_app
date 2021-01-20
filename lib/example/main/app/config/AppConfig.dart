import 'package:shared_preferences/shared_preferences.dart';

/// Khi scan thi xoa hết thông tin di ...
class AppConfig {
  static var IndexCurrentPlay = "IndexCurrentPlay";
  int indexCurrentPlay = 0;

  AppConfig._privateConstructor();

  static final AppConfig instance = AppConfig._privateConstructor();

  setIndexCurrentPlay(int value) async {
    assert(value >= 0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(IndexCurrentPlay, value);
  }

  getIndexCurrentPlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt(IndexCurrentPlay);
    if ((value != null) && (value >= 0)) {
      return value;
    } else {
      return 0;
    }
  }
}
