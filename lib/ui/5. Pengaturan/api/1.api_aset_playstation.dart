import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiAsetPlaystation {
  static Future<http.Response> viewAset() async {
    http.Response response = await http.get(
      Uri.parse("${AuthService.url}/asetps/v"),
      headers: await AuthService.authorizationHeader(),
    );
    return response;
  }

  static Future<void> tambahMeja({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/asetps/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("tambahMeja responseCode : ${response.statusCode}, responseHeader : ${response.headers}");
  }

  static Future<void> editMeja({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/asetps/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("editMeja responseCode : ${response.statusCode}");
  }

  static Future<void> removeMeja({required Map<String, dynamic> map}) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/asetps/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("removeMeja responseCode : ${response.statusCode}");
  }
}
