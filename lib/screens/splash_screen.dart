
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_chat2/api/apis.dart';
import 'package:quick_chat2/screens/home_screen.dart';

import 'auth/login_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

//comment

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      if (APIs.auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .25,
            width: mq.width * .5,
            left: mq.width * .25,
            child: Image.asset('images/message.png'),
          ),
          Positioned(
            bottom: mq.height * .25,
            left: mq.width * .18,
            child: Text(
              'Developed By Shohan',
              style: TextStyle(
                fontSize: 25.0,
                color: Color.fromARGB(255, 147, 99, 242),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
