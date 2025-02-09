import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static Future<Map<String, dynamic>?> retornarValor(String chave) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? valor = prefs.getString(chave);

    return json.decode(valor!);
  }

  static Future<void> salvarValor(String chave, Map<String, dynamic> valor) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = json.encode(valor);

    prefs.setString(chave, jsonString);
  }


}