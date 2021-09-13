import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiDaftarDagangan {
  static Future<http.Response> viewBarang({required int halaman}) async {
    http.Response? httpResponse = await http.get(Uri.parse("${AuthService.url}/dagangop/v?hal=$halaman"));
    return httpResponse;
  }

  static Future<void> addDagangan({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/dagangan/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("addDagangan responseCode : ${response.statusCode}");
  }

  static Future<void> updateDagangan({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/dagangan/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("updateDagangan responseCode : ${response.statusCode}");
  }

  static Future<void> tambahStok({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/dagangan/j"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("tambahStok responseCode : ${response.statusCode}");
  }

  static Future<void> removeDagangan({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/dagangan/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("removeDagangan responseCode : ${response.statusCode}");
  }
}
