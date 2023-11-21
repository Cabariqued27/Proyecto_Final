import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/volunteer.dart';


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
