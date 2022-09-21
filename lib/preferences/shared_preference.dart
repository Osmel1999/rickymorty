import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<String> get favorites {
    List<String> value = _prefs.getStringList('db_fav') ?? [];
    return value;
  }

  set favorites(List<String> value) {
    _prefs.setStringList('db_fav', value);
  }
}
