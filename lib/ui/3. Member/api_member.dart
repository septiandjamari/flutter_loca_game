import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiMember {
  static Future<http.Response> getInfoAllMember() async {
    return await http.get(
      Uri.parse("${AuthService.url}/member/v"),
      headers: await AuthService.authorizationHeader(),
    );
  }

  static Future<void> addListMember(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/member/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("addListMember responseCode : ${response.statusCode}");
  }

  static Future<void> editMember(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/member/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("editMember responseCode : ${response.statusCode}");
  }

  static Future<void> hapusMember(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/member/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("hapusMember responseCode : ${response.statusCode}");
  }
}
