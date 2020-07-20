import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ido_explorer/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FluroRouter.setupRouter();
    return MaterialApp(
      title: 'Flutter Web',
      initialRoute: '/',
      onGenerateRoute: FluroRouter.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: GoogleFonts.redHatTextTextTheme(Theme.of(context).textTheme),
        fontFamily: GoogleFonts.aleo().toString(),

        //canvasColor: Colors.transparent,
        //Theme.ofcontext().copywith
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
