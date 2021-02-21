import 'package:chat_app/components/authentication_firestore.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/round_button.dart';
import 'package:provider/provider.dart';


String email= '';
String password = '' ;

class LoginScreen extends StatelessWidget {
  static const navName = '/login';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFE6DD8E),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<AuthenticateUser>(builder: (context, _userData, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 5,),
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 100.0,
                      child: CircleAvatar (
                        backgroundColor: Color(0xFF393e46),
                                            child: Text('⚡️',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 70.0, shadows: [
                          BoxShadow(
                              color: Color(0xFF393e46),
                              blurRadius: 3,
                              spreadRadius: 4),
                        ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your E-Mail')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password')),
                SizedBox(
                  height: 70.0,
                  child: Center(
                    child: _userData.loading
                        ? CircularProgressIndicator(
                            strokeWidth: 8.0,
                          )
                        : Text(
                            _userData.errorMessage,
                            style: TextStyle(color: Color(0xFF000000)),
                          ),
                  ),
                ),
                RoundButton(
                  coloure: Color(0xFF393e46),
                  lable: "Login",
                  onPressed: () {
                    _userData.logUser(
                      email,
                      password,
                      ()=> Navigator.popAndPushNamed(context, ChatScreen.navName),
                    );
                    
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Color(0xFF303030),
                    onPressed: () {_userData.reset(); Navigator.pop(context);}),
              ],
            );
          }),
        ),
      ),
    );
  }
}
