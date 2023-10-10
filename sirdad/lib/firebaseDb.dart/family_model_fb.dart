import 'package:firebase_database/firebase_database.dart';
final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

void addFamily(
    String barrio,
    String address,
    int phone,
    String date,
    String eventId,
) {
  databaseReference.child("families").push().set({
    'barrio': barrio,
    'address': address,
    'phone': phone,
    'date': date,
    'eventId': eventId,
  });
}
