
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/event.dart';

class User {
  final String name;
  final int idv; // Cédula
  final int phonev;
  final String ong;
  final String sign;
  final String news;
  bool hasAccess;

  User(
    this.name,
    this.hasAccess, {
    this.idv = 0,
    this.phonev = 0,
    this.ong = '',
    this.sign = '',
    this.news = '',
  });
}

class UserProvider with ChangeNotifier {
  List<User> _users = [
    
    // Agrega más usuarios según sea necesario
  ];

  List<User> get users => _users;

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void toggleUserAccess(int index) {
    _users[index].hasAccess = !_users[index].hasAccess;
    notifyListeners();
  }
}