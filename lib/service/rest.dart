import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Service with ChangeNotifier {
  final dio = Dio();
  List respMap = [];
  String error = "";
  String db_selected = "character";
  String url = "https://rickandmortyapi.com/api/";

  Service() {
    initConfig();
  }
  Future initConfig() async {
    try {
      final resp = await dio.get(url + db_selected);
      respMap = resp.data["results"];
    } catch (e) {
      respMap = [];
    }
    notifyListeners();
  }
}
