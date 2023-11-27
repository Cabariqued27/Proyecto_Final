import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/family.dart';

class FamilyData extends ChangeNotifier {
  List<Family> _familys = [];
  List<Family> get familys => _familys;

  Future<void> addFamily(Family family) async {
    _familys.add(family);
    //await family.save();
    notifyListeners();
  }

  Future<void> getFamilysByEventId(String eventId) async {
  FirebaseDatabase.instance.ref().keepSynced(true);
  final ref = FirebaseDatabase.instance.ref().child('familys');

  ref.onValue.listen((family) {
    _familys.clear();
    if (family.snapshot.exists) {
      final Map<dynamic, dynamic> data =
          family.snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        String barrio = value['barrio'] ?? "";
        String address = value['address'] ?? "";
        int phone = value['phone'] ?? "";
        String date = value['date'] ?? "";
        String jefe = value['jefe'] ?? "";
        String familyEventId = value['eventId'] ?? "";

        if (familyEventId == eventId) {
          Family newFamily = Family(
            idf: key,
            barrio: barrio,
            address: address,
            phone: phone,
            date: date,
            jefe: jefe,
            eventId: familyEventId,
          );
          addFamily(newFamily);
        }
      });
    } else {
      print('No data available.');
    }
  });
}

}
