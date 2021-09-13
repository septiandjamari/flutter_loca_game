import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiDaftarOperator {
  static Future<http.Response> ngeListUsers() async {
    http.Response response = await http.get(
      Uri.parse("${AuthService.url}/user/admin/v"),
      headers: await AuthService.authorizationHeader(),
    );
    return response;
  }

  static Future<void> ngeAddUser(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/user/admin/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeAddUser responseCode : ${response.statusCode}");
  }

  static Future<void> ngeditUser(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/user/admin/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeditUser responseCode : ${response.statusCode}");
  }

  static Future<void> ngeDelUser(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/user/admin/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeDelUser responseCode : ${response.statusCode}");
  }
}
