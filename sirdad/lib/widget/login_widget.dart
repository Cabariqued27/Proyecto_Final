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
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const Text('Login Page'),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
    );
  }
}
