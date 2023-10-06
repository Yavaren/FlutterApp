import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super (key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Login')
        ),
        body: FutureBuilder (

          future: Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    ),

          builder: (context, snapshot) {

              return Column(
               children: [
                
                TextField(
                  controller: _email,
                  autocorrect: false,
                  enableSuggestions: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email'),
                  ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Create a new password'),
                  ),
                TextButton(
                  onPressed: () async {
                    final usereEmail = _email.text;
                    final userPassword = _password.text;
                    try {
                    final UserCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: usereEmail, 
                      password: userPassword);
                      print(UserCredential);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('User not found'); 
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password');
                        print(e.code); 
                      }
                    }
                  }, 
                  child: const Text('Login')),
               ],
             );
          },
        ),
      );
  }
}