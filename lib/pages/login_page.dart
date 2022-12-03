import 'package:cliente_entradas/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
          leading: Icon(Icons.rocket),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.vpn_key),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                child: Text('google login'),
                onPressed: () => signInWithGoogle(),
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () => login(),
              ),
            ],
          ),
        ));
  }

  void pushPage(BuildContext context, Widget page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('userEmail', userCredential.user!.email.toString());
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'user-not-found':
          error = 'Usuario no existe';
          break;
        case 'wrong-password':
          error = 'Contraseña incorrecta';
          break;
        case 'user-disabled':
          error = 'Cuenta desactivada';
          break;
        default:
          error = ex.message.toString();
          break;
      }
      setState(() {});
    }
  }
}
