import 'package:IDO_Kira/router.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FluroRouter.setupRouter();
    return MaterialApp(
      title: 'Kira IDO Explorer',
      initialRoute: '/',
      onGenerateRoute: FluroRouter.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.robotoSlab().toString(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
