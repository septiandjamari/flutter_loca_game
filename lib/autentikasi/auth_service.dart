import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String spCred = "spCred";
  static String spFile = "spFile";
  static String spRole = "spRole";
  static String spStatus = "spStatus";
  static String spUser = "spUser";

  // static String url = "http://192.168.0.150:5000"; // wifi kak raf
  static String url = "http://192.168.43.115:5000"; // wifi hp laptop
  // static String url = "http://192.168.43.9:5000"; // wifi hp komputer

  static Future<http.Response> login({required String username, required String password, String? lisensi}) async {
    print("Api Login Dijankan...");
    http.Response response = await http.post(
      Uri.parse("$url/user/login"),
      body: jsonEncode({"username": username, "password": password, "file": lisensi}),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      setUserInfo(mapBody: jsonDecode(response.body));
    }
    return response;
  }

  static Future<String> getCredential() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String cred = sp.getString(spCred)!;
    return cred;
  }

  static Future<Map<String, String>> authorizationHeader() async {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${await AuthService.getCredential()}',
    };
  }

  static Future<void> logout(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    BlocLogin getIndex = BlocProvider.of<BlocLogin>(context);
    sp.clear();
    getIndex.add(0);
  }

  static void setBlocLoginState({required BuildContext context, required int valueState}) {
    BlocLogin getIndex = BlocProvider.of<BlocLogin>(context);
    getIndex.add(valueState);
  }

  static Future<void> setUserInfo({required Map<String, dynamic> mapBody}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(spCred, mapBody["cred"]);
    sp.setString(spFile, mapBody["file"]);
    sp.setString(spRole, mapBody["role"]);
    sp.setBool(spStatus, mapBody["status"]);
    sp.setString(spUser, mapBody["user"]);
  }
}

class BlocLogin extends Bloc<int, int> {
  BlocLogin() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
