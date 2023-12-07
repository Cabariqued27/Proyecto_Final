import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _idvController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ongController = TextEditingController();
  final _signController = TextEditingController();
  final _newsController = TextEditingController();
  final _hasAccessController = TextEditingController();
  final _isAdminController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
    _idvController.dispose();
    _phoneController.dispose();
    _ongController.dispose();
    _signController.dispose();
    _newsController.dispose();
    _hasAccessController.dispose();
    _isAdminController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                //MyButton(
                // onTap: //signUserIn,
                //),

                const SizedBox(height: 50),
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
