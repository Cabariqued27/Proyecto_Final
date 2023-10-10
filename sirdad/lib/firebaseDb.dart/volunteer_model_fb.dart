import 'package:firebase_database/firebase_database.dart';
final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

void addVolunteer(
  String namev,
  String nidv,
  String phonev,
  String ong,
  String sign,
  String news,
) {
  databaseReference.child("volunteers").push().set({
    'namev': namev,
    'nidv': nidv,
    'phonev': phonev,
    'ong': ong,
    'sign': sign,
    'news': news,
  });
}
