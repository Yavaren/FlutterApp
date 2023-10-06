import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
       ),
      home: const HomePage(),
    ));
}

/* -------------------------------------------------------------------------- */

class HomePage extends StatelessWidget {
  const HomePage
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Home')
        ),
        body: FutureBuilder (
          future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print('You are a verified user');
              } else {
                print('You need to verify your email');
              }
                return Text("Done");
              case ConnectionState.active:
                return Text("Loading...");
              case ConnectionState.none:
                return Text("Failed");
              case ConnectionState.waiting:
                return Text("Waiting");
            }
          },
        ),
      );
  }
}