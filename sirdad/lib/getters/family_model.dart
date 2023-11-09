import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/family_widget.dart';

class FamilyData extends ChangeNotifier {
  List<Family> _familys = [];
  List<Family> get familys => _familys;

  Future<void> addFamily(Family family) async {
    _familys.add(family);
    await family.save();
    notifyListeners();
  }

  Future<void> getfamilysfb() async {
    final ref = FirebaseDatabase.instance.ref().child('familys');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        String barrio = value['barrio'];
        String address = value['address'];
        int phone = value['phone'];
        String date = value['date'];
        String jefe = value['jefe'];
        String eventId = value['eventId'];

        Family newFamily = Family(
            barrio: barrio,
            address: address,
            phone: phone,
            date: date,
            jefe: jefe,
            eventId: eventId);
        addFamily(newFamily);
      });
    } else {
      print('No data available.');
    }
  }
}
