import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/models/member.dart';

class MemberData extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> get members => _members;

  Future<void> addMember(Member member) async {
    _members.add(member);
    await member.save();
    notifyListeners();
  }

  Future<void> getmembersfb() async {
    final ref = FirebaseDatabase.instance.ref().child('members');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        int idm = data['idm'] ?? 0;
        String name = data['name']??"";
        String surname = data['surname']??"";
        int kid = data['kid']??0;
        int nid = data['nid']??0;
        int rela = data['rela']??0;
        String gen = data['gen']??"";
        int age = data['age']??0;
        int et = data['et']??0;
        int heal = data['heal']??0;
        int aheal = data['aheal']??0;
        int familyId = data['familyId']??0;

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
            familyId: familyId);
        addMember(newMember);
      });
    } else {
      print('No data available.');
    }
  }
}
