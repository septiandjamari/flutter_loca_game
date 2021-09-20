import 'dart:convert';

import 'package:file_picker/file_picker.dart';
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
  String lisensiString = "";

  bool lisensiIsLoaded = false;

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
                  // obscureText: true,
                  controller: password,
                  decoration: InputDecoration(hintText: "Password"),
                  onChanged: (_) {
                    setState(() {
                      passwordString = _;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    tileColor: lisensiString == "" ? Colors.red.shade50 : Colors.green.shade50,
                    title: Text("Lampirkan file lisensi"),
                    subtitle: Text(lisensiString == "" ? "File lisensi belum dimasukkan" : "File lisensi sudah dimasukkan", style: TextStyle(color: lisensiString == "" ? Colors.red : Colors.green),),
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                      late PlatformFile file;
                      if (result != null) {
                        file = result.files.first;
                        setState(() {
                          lisensiString = file.name;
                        });
                        print(file.name);
                      } else {
                        setState(() {
                          lisensiString = "";
                          print("batal tambah file");
                        });
                      }
                    },
                    leading: Icon(Icons.file_present),
                    trailing: lisensiString == ""
                        ? Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                    dense: true,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed:
                      usernameString == "" && passwordString == "" && lisensiString == "" || usernameString == "" || passwordString == "" || lisensiString == ""
                          ? null
                          : () async {
                              http.Response response = await AuthService.login(username: username.text, password: password.text, lisensi: lisensiString);
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
