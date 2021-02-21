import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import '../components/round_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const navName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE6DD8E),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Text(
                    '⚡️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 150.0,
                    ),
                  ),
                ),
              ),
              Container(
                child: TypewriterAnimatedTextKit(
                  isRepeatingAnimation: false,
                  speed: Duration(seconds: 5),
                  text: ['Chat App'],
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      shadows: [
                        BoxShadow(
                            color: Color(0xFF393e46),
                            blurRadius: 5,
                            spreadRadius: 6,
                            offset: Offset(2, 2))
                      ],
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFeeeeeee)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundButton(
                coloure: Color(0xFF393e46),
                lable: "Login",
                onPressed: () =>
                    Navigator.pushNamed(context, LoginScreen.navName),
              ),
              RoundButton(
                coloure: Color(0xFF222831),
                lable: "Register",
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.navName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
