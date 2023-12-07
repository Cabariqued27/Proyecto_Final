import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/components/my_button.dart';
import 'package:sirdad/components/my_textfield.dart';
import 'package:sirdad/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor:
              Colors.deepOrange, // Set background color to deep orange
          title: Center(
            child: Text(
              'Correo electrónico incorrecto',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor:
              Colors.deepOrange, // Set background color to deep orange
          title: Center(
            child: Text(
              'Contraseña incorrecta',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set background color to orange
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo

                // logo using Image widget
                Image.asset(
                  'lib/assets/logo.png', // Replace with the actual path to your image asset
                  width: 100,
                  height: 100,
                  color: Colors.white, // Set image color to white
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Correo electrónico',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '¿Ha olvidado su contraseña?',
                        style: TextStyle(
                            color: Colors.white), // Set text color to white
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 50),

                // or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white, // Set divider color to white
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O continuar con',
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white, // Set divider color to white
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google sign in button
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/assets/google.png'),
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No está afiliado?',
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Regístrese ahora',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
