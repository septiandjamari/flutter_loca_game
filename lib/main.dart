import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loca_game/autentikasi/auth_service.dart';
// import 'package:flutter_loca_game/autentikasi/halaman_utama.dart';
import 'package:flutter_loca_game/autentikasi/page_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_loca_game/autentikasi/page_wrapper.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocLogin>(
      create: (context) => BlocLogin(),
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [Locale('id')],
        title: 'Loca Game',
        theme: ThemeData.dark(),
        home: PageWrapper(),
      ),
    );
  }
}

