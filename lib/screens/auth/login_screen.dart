// import 'dart:math';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_chat2/api/apis.dart';
import 'package:quick_chat2/screens/home_screen.dart';
import 'package:quick_chat2/helper/dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        _changeOpacity();
      });
    });
  }

  _handleGoogleButtonClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        print('user: ${user.user}');
        print('user Additional info: ${user.additionalUserInfo}');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      print("_signInWithGoogle: $e");
      Dialogs.showSnackbar(
          context, 'Something went wrong. Check the internet.');
      return null;
    }
  }

  double opacityLevel = 0.0;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to Quick Chat'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            width: mq.width * .5,
            left: mq.width * .25,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: opacityLevel,
              child: Image.asset('images/message.png'),
            ),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .15,
            width: mq.width * .7,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              onPressed: () {
                _handleGoogleButtonClick();
              },
              icon: Image.asset(
                'images/google.png',
                // width: mq.width * .5,
                height: mq.height * .05,
              ),
              label: const Text('Sign with Google'),
            ),
          ),
        ],
      ),
    );
  }
}
