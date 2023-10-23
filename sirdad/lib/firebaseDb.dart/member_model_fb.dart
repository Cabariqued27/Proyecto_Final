import 'package:firebase_database/firebase_database.dart';
final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

void addMember(
    String name,
    String surname,
    int kid,
    int nid,
    int rela,
    String gen,
    int age,
    int et,
    int heal,
    int aheal,
    String familyId,
) {
  databaseReference.child("members").push().set({
    'name': name,
    'surname': surname,
    'kid': kid,
    'nid': nid,
    'rela': rela,
    'gen': gen,
    'age': age,
    'et': et,
    'heal': heal,
    'aheal': aheal,
    'familyId': familyId,
  });
}
