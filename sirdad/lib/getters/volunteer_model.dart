import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/volunteer.dart';

class VolunteerData with ChangeNotifier {
  final List<Volunteer> _volunteers = [];
  List<Volunteer> get volunteers => _volunteers;

  Future<void> addVolunteer(Volunteer volunteer) async {
    print('entré');
    _volunteers.add(volunteer);
    notifyListeners();
  }

  void togglevolunteerAccess(int index) {
    _volunteers[index].hasAccess = !_volunteers[index].hasAccess;
    notifyListeners();
  }

  Future<void> getVolunteers() async {
    FirebaseDatabase.instance.ref().keepSynced(true);
    final ref = FirebaseDatabase.instance.ref().child('volunteers');

    ref.onValue.listen((volunteer) {
      _volunteers.clear();

      if (volunteer.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            volunteer.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String namev = value['barrio'] ?? "";
          bool hasAccess = value['hasAccess'] ?? false;
          int phonev = value['phonev'] ?? 0;
          String ong = value['ong'] ?? "";
          String sign = value['sign'] ?? "";
          String news = value['news'] ?? "";
          bool isAdmin = value['isAdmin'] ?? false;

          print('namev: $namev');
          print('hasAccess: $hasAccess');
          print('phonev: $phonev');
          print('ong: $ong');
          print('sign: $sign');
          print('news: $news');
          print('isAdmin: $isAdmin');

          Volunteer newVolunteer = Volunteer(
              idv: key,
              namev: namev,
              hasAccess: hasAccess,
              phonev: phonev,
              ong: ong,
              sign: sign,
              news: news,
              isAdmid: isAdmin
              );
          print('entré');
          addVolunteer(newVolunteer);
          print(newVolunteer);
        });
      } else {
        print('No data available.');
      }
    });
  }
}
