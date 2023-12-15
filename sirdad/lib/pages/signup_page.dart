import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/components/my_button.dart';
import 'package:sirdad/components/my_textfield.dart';
import 'package:sirdad/models/volunteer.dart';

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
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('volunteers');
    // Set default values for each controller
    _emailController.text = 'default@gmail.com';
    _passwordController.text = '123456';
    _confirmpasswordController.text = '123456';
    _nameController.text = 'Default Name';
    _idvController.text = 'Default IDV';
    _phoneController.text = '311';
    _ongController.text = 'Onu';
    _signController.text = 'Default Sign';
    _newsController.text = 'Default News';
    _hasAccessController.text = 'false';
    _isAdminController.text = 'false';
  }

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
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the UID from the UserCredential
        final String uid = credential.user!.uid;

        Volunteer newVolunteer = Volunteer(
          namev: _nameController.text.trim(),
          phonev: int.parse(_phoneController.text),
          ong: _ongController.text.trim(),
          sign: _signController.text.trim(),
          news: _newsController.text.trim(),
          hasAccess: false,
          isAdmid: false,
        );

        // Save the user details with UID as ID in the database
        dbRef.child(uid).set({
          'Name': newVolunteer.namev,
          'Phone': newVolunteer.phonev,
          'Ong': newVolunteer.ong,
          'Sign': newVolunteer.sign,
          'News': newVolunteer.news,
          'HasAcces': newVolunteer.hasAccess,
          'isAdmin': newVolunteer.isAdmid,
          // Add other fields as needed
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
        } else if (e.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    Navigator.pop(context);



  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmpasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Registro de Voluntarios',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Correo electrónico',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _confirmpasswordController,
                  hintText: 'Confirmar Contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _nameController,
                  hintText: 'Nombre',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _phoneController,
                  hintText: 'Teléfono',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _ongController,
                  hintText: 'ONG',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _signController,
                  hintText: 'Sign',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _newsController,
                  hintText: 'News',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyButton(
                  onTap: signUp,
                  buttonText: 'Sing Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
