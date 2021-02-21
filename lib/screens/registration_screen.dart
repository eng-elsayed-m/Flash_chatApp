import 'package:chat_app/components/authentication_firestore.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/round_button.dart';
import '../constants.dart';
import 'package:provider/provider.dart';


String email='';
String password= '' ;

class RegistrationScreen extends StatelessWidget {
  static const navName = '/registration';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          backgroundColor: Color(0xFFE6DD8E),
          body: Consumer<AuthenticateUser>(builder: (context, _userData, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 100.0,
                      child: CircleAvatar (
                        backgroundColor: Color(0xFF222831),
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
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter E-Mail'),
                  ),
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
                          hintText: 'Enter new password')),
                  SizedBox(
                      height: 60.0,
                      child: Center(
                        child: _userData.loading
                            ? CircularProgressIndicator(
                                strokeWidth: 7.0,
                              )
                            : Text(
                                _userData.errorMessage,
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                      )),
                  RoundButton(
                    coloure: Color(0xFF222831),
                    lable: "Register",
                    onPressed: () {
                      _userData.creatUser(email, password , ()=>Navigator.popAndPushNamed(context, ChatScreen.navName));
                      
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color(0xFF303030),
                      onPressed: (){
                      _userData.reset();
                      Navigator.pop(context);}),
                ],
              ),
            );
          })),
    );
  }
}
