import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text("Register View")),
      body: Column(
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
                      final UserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: usereEmail, 
                        password: userPassword); 
                        print(UserCredential);
                      } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak password');
                          }
                      }
                    }, 
                    child: const Text('register')
                    ),
                    TextButton(onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/', 
                        (route) => false);
                    }, child: const Text('Already Registered? Login here'))
                 ],
               ),
    );
  }
}