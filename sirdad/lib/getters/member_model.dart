import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/models/member.dart';

class MemberData extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> get members => _members;

  Future<void> addMember(Member member) async {
    _members.add(member);
    notifyListeners();
  }

  Future<void> getMembersFromCache() async {
    FirebaseDatabase.instance.ref().keepSynced(true);
    final ref = FirebaseDatabase.instance.ref().child('members');

    ref.onValue.listen((member) {
      _members.clear();
      if (member.snapshot.exists) {
        final Map<dynamic, dynamic> data = member.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          int idm = value['idm'] ?? 0;
          String name = value['name'] ?? '';
          String surname = value['surname'] ?? '';
          int kid = value['kid'] ?? 0;
          int nid = value['nid'] ?? 0;
          int rela = value['rela'] ?? 0;
          String gen = value['gen'] ?? '';
          int age = value['age'] ?? 0;
          int et = value['et'] ?? 0;
          int heal = value['heal'] ?? 0;
          int aheal = value['aheal'] ?? 0;
          int sh = value['sh'] ?? '';
          String familyId = value['familyId'] ?? 0;

          Member newMember = Member(
            idm: idm,
            name: name,
            surname: surname,
            kid: kid,
            nid: nid,
            rela: rela,
            gen: gen,
            age: age,
            et: et,
            heal: heal,
            aheal: aheal,
            sh:sh,
            familyId: familyId,
          );
          print(newMember);
          addMember(newMember);
        });
      } else {
        print('No data available.');
      }
    });
  }
}
