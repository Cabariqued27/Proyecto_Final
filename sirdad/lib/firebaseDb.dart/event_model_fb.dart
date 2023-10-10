import 'package:firebase_database/firebase_database.dart';
final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

void addEvent(String name, String description, String date) {
  databaseReference.child("events").push().set({
    'name': name,
    'description': description,
    'date': date,
  });
}