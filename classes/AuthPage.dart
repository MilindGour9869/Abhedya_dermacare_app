import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/sign_up_screen.dart';


class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool loginscreen = true;

  void toggle(){
    setState(() {
      loginscreen=!loginscreen;

    });
  }

  @override
  Widget build(BuildContext context) {
    return loginscreen?LoginScreen(
      f: toggle,
    ):SignUpScreen(
      f: toggle,
    );
  }
}
