import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/acceso_model.dart';
import 'package:sirdad/models/volunteer.dart';
import 'package:sirdad/widget/acceso_widget.dart';

import '../getters/event_model.dart';
import '../models/event.dart';
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

  // Define a list of allowed users
  // final List<User> allowedUsers = [
  //   User(username: 'admin', password: 'password', isAdmin: true),
  //   User(username: 'user', password: '123456', isAdmin: false),
  // ];

  // Verify if the user is allowed to proceed
  // User? verifyAdmin() {
  //   for (final user in allowedUsers) {
  //     if (user.username == username && user.password == password) {
  //       return user;
  //     }
  //   }
  //   return null;
  // }

  verifyUser(String username, String password) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    for (final user in userProvider.users) {
      if (user.namev == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  // void _login(String username, String password) {
  //   final verifiedUser = verifyUser(username, password);
  //   if (verifiedUser != null) {
  //     if (verifiedUser.isAdmin) {
  //       // Navigate to the admin panel or authenticated area
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => AccesoScreen()),
  //       );
  //     } else {
  //       // Navigate to the regular user panel or authenticated area
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => MyApp()),
  //       );
  //     }
  //   } else {
  //     // Handle invalid login or show an error message
  //     print('Invalid login');
  //   }
  // }

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
    // Eliminar la AppBar
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: Container(),
    ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        // Añadir decoración al Container que contiene todo
        decoration: BoxDecoration(
          color: Colors.white, // Puedes cambiar el color de fondo según tus necesidades
          borderRadius: BorderRadius.circular(20.0), // Bordes curvos
          border: Border.all(color: Colors.orange, width: 12.0), // Borde naranja
        ),
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
                // TextField para Username con borde naranja y curvas
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.orange, width: 2.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: InputBorder.none, // Eliminar el borde predeterminado
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // TextField para Password con borde naranja y curvas
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.orange, width: 2.0),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none, // Eliminar el borde predeterminado
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
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
    ));
  }
}





