import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
import 'package:flutter_loca_game/autentikasi/halaman_login.dart';
import 'package:flutter_loca_game/autentikasi/halaman_utama.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({Key? key}) : super(key: key);

  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocLogin, int>(builder: (context, index) {
      return index == 0 ? HalamanLogin() : HalamanUtama();
    });
  }
}
