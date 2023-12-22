import 'package:flutter/material.dart';

import '../homescreen/list_screen.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String assetsPath = "assets/Scissors-image-remove.png";
    Color assetsColor = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              "assets/first.jpg", // Replace with your image asset path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child:ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        assetsColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        assetsPath,
                        width: 100.0, // Adjust the width as needed
                        height: 100.0, // Adjust the height as needed
                      ),
                    ) ,
                  ),     //Scissors image
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'SCISSOR\'S ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  Icon(Icons.spa_outlined, size: 50,color:Colors.white),
                  Text(
                    'WELCOME TO SCISSOR\'S SALOON',
                    style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child:IconButton(
                            onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListScreen()));

                            },
                            icon:  Icon(Icons.person_outline_outlined,size: 65,color:Colors.black) ),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        "USER",
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    indent: 300,
                    endIndent: 300,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 39,
                        child: IconButton(
                            onPressed:(
                                login()
                            ),
                            icon: Icon(Icons.admin_panel_settings_outlined,size:65,color:Colors.black)) ,
                      ),
                      SizedBox(width: 15,),
                      Text(
                        "ADMIN",
                        style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                      ),



                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() {}
}