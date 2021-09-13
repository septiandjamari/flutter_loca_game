import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiDaftarHargaPaketPS {
  static Future<http.Response> infoAllPaketPS() async {
    http.Response response = await http.get(
      Uri.parse("${AuthService.url}/paketps/v"),
      headers: await AuthService.authorizationHeader(),
    );
    return response;
  }

  static Future<void> addPaketPS({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/paketps/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("addPaketPS responseCode : ${response.statusCode}");
  }

  static Future<void> updatePaketPS({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/paketps/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("updatePaketPS responseCode : ${response.statusCode}");
  }

  static Future<void> hapusPaketPS({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/paketps/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("hapusPaketPS responseCode : ${response.statusCode}");
  }
}
