import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/acceso_model.dart';
import 'package:sirdad/widget/acceso_widget.dart';
import 'event_widget.dart';

class User {
  final String username;
  final String password;
  final bool isAdmin;

  User({
    required this.username,
    required this.password,
    required this.isAdmin,
  });
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page Example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';


  verifyUser(String username, String password) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    for (final user in userProvider.users) {
      if (user.namev == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  _login(String username, String password) {
    final verifiedUser = verifyUser(username, password);
    // final verifiedAdmin = verifyAdmin();
    if (verifiedUser != null) {
      if (verifiedUser.isAdmid) {
        // Navigate to the admin panel or authenticated area
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccesoScreen()),
        );
      } else {
        // Navigate to the regular user panel or authenticated area
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    } else {
      // Handle invalid login or show an error message
      print('Invalid login');
    }
  }




@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        children: <Widget>[
          const Text(''),
          const SizedBox(width: 16.0),
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Contenedor para la imagen
                Container(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: const Image(
                    image: NetworkImage('https://seeklogo.com/images/D/defensa-civil-colombiana-logotipo-nuevo-logo-77F9660C5D-seeklogo.com.png'),
                    height: 200,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    _login(username, password);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}



}