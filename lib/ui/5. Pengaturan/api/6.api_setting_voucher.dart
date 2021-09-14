import 'dart:convert';

import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiSettingVoucher {
  static Future<http.Response> getVoucher() async {
    return await http.get(
      Uri.parse("${AuthService.url}/voucher/v"),
      headers: await AuthService.authorizationHeader(),
    );
  }

  static Future<void> createVoucher(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/voucher/a"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("createVoucher responseCode : ${response.statusCode}");
  }

  static Future<void> editVoucher(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/voucher/u"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("editVoucher responseCode : ${response.statusCode}");
  }

  static Future<void> delVoucher(Map<String, dynamic> map) async {
    http.Response response = await http.post(
      Uri.parse("${AuthService.url}/voucher/r"),
      body: jsonEncode(map),
      headers: await AuthService.authorizationHeader(),
    );
    print("delVoucher responseCode : ${response.statusCode}");
  }
}
