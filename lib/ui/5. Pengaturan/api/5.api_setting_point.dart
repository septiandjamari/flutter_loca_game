import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiSettingPoint {
  static Future<http.Response> getInfoDepositPerPoint() async {
    return await http.get(
      Uri.parse("${AuthService.url}/member/p"),
      headers: await AuthService.authorizationHeader(),
    );
  }

  static Future<void> setDepositPerPoint(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/member/sp"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("setDepositPerPoint responseCode : ${response.statusCode}");
  }

  static Future<http.Response> getPointHadiah() async {
    return await http.get(
      Uri.parse("${AuthService.url}/pointhadiah/v"),
      headers: await AuthService.authorizationHeader(),
    );
  }

  static Future<void> ngeAddPoint(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/pointhadiah/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeAddPoint responseCode : ${response.statusCode}");
  }

  static Future<void> ngeditPoint(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/pointhadiah/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeditPoint responseCode : ${response.statusCode}");
  }

  static Future<void> ngeDelPoint(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/pointhadiah/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("ngeDelPoint responseCode : ${response.statusCode}");
  }
}
