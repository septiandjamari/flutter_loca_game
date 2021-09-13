import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:http/http.dart' as http;

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({Key? key}) : super(key: key);

  @override
  _HalamanLoginState createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  TextEditingController username = TextEditingController();
  String usernameString = "";
  TextEditingController password = TextEditingController();
  String passwordString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.contain, image: AssetImage('assets/images/locabillps.png')),
                  ),
                ),
                SizedBox(height: 36),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(hintText: "Username"),
                  onChanged: (_) {
                    setState(() {
                      usernameString = _;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(hintText: "Password"),
                  onChanged: (_) {
                    setState(() {
                      passwordString = _;
                    });
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: usernameString == "" && passwordString == "" || usernameString == "" || passwordString == ""
                      ? null
                      : () async {
                          http.Response response = await AuthService.login(username: username.text, password: password.text);
                          var responseBody = jsonDecode(response.body);
                          print(responseBody);
                          if (responseBody["status"] == true) {
                            AuthService.setBlocLoginState(context: context, valueState: 1);
                          } else {
                            AuthService.setBlocLoginState(context: context, valueState: 0);
                          }
                        },
                  child: Center(child: Text("LOGIN")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
