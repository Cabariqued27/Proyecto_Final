import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/volunteer.dart';

import '../models/event.dart';

// class User {
//   final String name;
//   final String password;
//   final int idv; // Cédula
//   final int phonev;
//   final String ong;
//   final String sign;
//   final String news;
//   bool hasAccess;
//   bool isAdmin;

//   User(
//     this.name,
//     this.password,
//     this.hasAccess, {
//     this.idv = 0,
//     this.phonev = 0,
//     this.ong = '',
//     this.sign = '',
//     this.news = '',
//     this.isAdmin = false,
//   });
// }

class UserProvider with ChangeNotifier {
  final List<Volunteer> _users = [
    // Agrega más usuarios según sea necesario
    Volunteer(
            namev: 'admin',
            password: 'password',
            hasAccess: true,
            isAdmid: true)
    
  ];

  List<Volunteer> get users => _users;

  Future<void> addUser(Volunteer user) async {
    _users.add(user);
    //user.save(); //ahora si guardo en BD local

    notifyListeners();
  }

  void toggleUserAccess(int index) {
    _users[index].hasAccess = !_users[index].hasAccess;
    notifyListeners();
  }
}
