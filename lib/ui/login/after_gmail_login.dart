import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/ui/login/welcome_login.dart';
import 'package:guilt_app/utils/google_auth/gmail_auth.dart';

class AfterGmailLogin extends StatefulWidget {
  const AfterGmailLogin({Key? key}) : super(key: key);

  @override
  _AfterGmailLoginState createState() => _AfterGmailLoginState();
}

class _AfterGmailLoginState extends State<AfterGmailLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
            SizedBox(
              height: 20,
            ),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () async {
                await FirebaseServices().googleSignOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomeLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }
}