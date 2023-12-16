import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/homescreen/list_screen.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: TextTheme()),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                      ),
                      Image.asset(
                        'assets/Scissors-image-remove.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 17.0)),
                    Text(
                      "Scissor's",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ]),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Services",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}