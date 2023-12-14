import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/volunteer.dart';

class UserProvider with ChangeNotifier {
  final List<Volunteer> _users = [
    Volunteer(
      namev: 'voluntario1',
      password: 'password',
      hasAccess: true,
      isAdmid: true,
    )
  ];
  List<Volunteer> get users => _users;
  final List<Volunteer> _usersf = [];
  List<Volunteer> get usersf => _usersf;

  Future<void> addUser(Volunteer user) async {
    _users.add(user);
    notifyListeners();
  }

  Future<void> addUserf(Volunteer user) async {
    _usersf.add(user);
    notifyListeners();
  }

  void toggleUserAccess(int index) {
    _usersf[index].hasAccess = !_usersf[index].hasAccess;
    notifyListeners();
  }

  Future<void> getVolunteers() async {
    FirebaseDatabase.instance.ref().keepSynced(true);
    final ref = FirebaseDatabase.instance.ref().child('volunteers');

    ref.onValue.listen((user) {
      _usersf.clear();
      Volunteer adminUser = _users.firstWhere((user) => user.isAdmid);
      _usersf.add(adminUser);
      if (user.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            user.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String namev = value['barrio'] ?? "";
          String password = value['password'] ?? "";
          bool hasAccess = value['hasAccess'] ?? "true";
          int phonev = value['phonev'] ?? "";
          String ong = value['ong'] ?? "";
          String sign = value['sign'] ?? "";
          String news = value['news'] ?? "";

          Volunteer newVolunteer = Volunteer(
            idv: key,
            namev: namev,
            password: password,
            hasAccess: hasAccess,
            phonev: phonev,
            ong: ong,
            sign: sign,
            news: news,
          );
          addUserf(newVolunteer);
        });
      } else {
        print('No data available.');
      }
    });
  }
}
