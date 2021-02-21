import 'package:chat_app/components/authentication_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, firebaseApp) {
        if (firebaseApp.hasData == true) {
          return ChangeNotifierProvider<AuthenticateUser>(
            create: (context) => AuthenticateUser(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark().copyWith(
                  textTheme: TextTheme(
                    subtitle1: TextStyle(color: Colors.black, fontSize: 20),
                    headline4: TextStyle(color: Colors.black45, fontSize: 30),
                    caption: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
                routes: {
                  "/": (context) => WelcomeScreen(),
                  WelcomeScreen.navName: (context) => WelcomeScreen(),
                  LoginScreen.navName: (context) => LoginScreen(),
                  RegistrationScreen.navName: (context) => RegistrationScreen(),
                  ChatScreen.navName: (context) => ChatScreen(),
                }),
          );
        }

        return MaterialApp(
          home: Scaffold(
            body: Container(
              child: Image.asset(
                'images/logo.png',
              ),
              height: 250,
            ),
          ),
        );
      },
    );
  }
}
// FirebaseStorage.instance
//             .ref('usersImages/' + _auth.currentUser.uid + '.jpg')
//             .getDownloadURL()
//             .then((url) {
//           _userImage = url;
//         });
