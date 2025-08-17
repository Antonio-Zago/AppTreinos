import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static Future<Map<String, dynamic>?> retornarValor(String chave) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? valor = prefs.getString(chave);
    if(valor != null){
      return json.decode(valor);
    }
    return null;
  }

  static Future<void> salvarValor(String chave, Map<String, dynamic> valor) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = json.encode(valor);

    prefs.setString(chave, jsonString);
  }

  static Future<void> resetarValor(String chave) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(chave);
  }


}