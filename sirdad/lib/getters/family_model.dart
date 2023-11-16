import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
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
    try {
      final ref = FirebaseDatabase.instance.reference().child('familys');
      final snapshot = await ref.get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String barrio = value['barrio'] ?? '';
          String address = value['address'] ?? '';
          int phone = value['phone'] ?? 0;
          String date = value['date'] ?? '';
          String eventId = value['eventId'] ?? '';

          Family newFamily = Family(
            barrio: barrio,
            address: address,
            phone: phone,
            date: date,
            eventId: eventId,
          );

          addFamily(newFamily);
        });
      } else {
        print('No data available.');
      }
    } catch (error) {
      print('Error fetching data from Firebase: $error');
    }
  }
}
