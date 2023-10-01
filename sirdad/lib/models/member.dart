import 'package:sirdad/services/tables.dart';
import '../services/crud.dart';
// Importa la clase member

class Member extends Crud {
  int idm;
  String name;
  String surname;
  int kid;
  int nid;
  int rela;
  String gen;
  int age;
  int et;
  int heal;
  int aheal;
  int familyId;

  Member({
    this.idm = 0,
    this.name = '',
    this.surname = '',
    this.kid = 0,
    this.nid = 0,
    this.rela = 0,
    this.gen = '',
    this.age = 0,
    this.et = 0,
    this.heal = 0,
    this.aheal = 0,
    this.familyId = 0,
  }) : super(memberTable);

  @override
  String toString() {
    return '\n Id: $idm Nombre: $name Edad: $age \n';
  }

  Member toObject(Map<dynamic, dynamic> data) {
    return Member(
      idm: data['idm'],
      name: data['name'],
      surname: data['surname'],
      kid: data['kid'],
      nid: data['nid'],
      rela: data['rela'],
      gen: data['gen'],
      age: data['age'],
      et: data['et'],
      heal: data['heal'],
      aheal: data['aheal'],
      familyId: data['familyId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idm': idm > 0 ? idm : null,
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
    };
  }

  save() async {
    print("Member");
    await ((idm > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(idm);
  }

  Future<List<Member>> getMembers() async {
    var resultf = await query('SELECT * FROM $memberTable');
    return _getListObject(resultf);
  }

  List<Member> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
