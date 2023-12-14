import 'package:sirdad/services/tables.dart';
import '../services/crud.dart';
//Importa la clase member

class Member extends Crud {
  int idm; 
  String name; 
  String surname;//chatgpt esto es apellidos
  int kid; //chatgpt esto es tipo de documento
  int nid;//Chatgpt esto es para el número de documento
  int rela;//Chatgpt esto es para el PARENTESCO CON EL JEFE DEL HOGAR
  String gen;//CHATGPT esto es para el GÉNERO
  int age;
  int et;//esto es para la etnia
  int heal;// esto es para el estado de salud
  int aheal; // chatgpt esto es para la AFILIACIÓN AL REGIMEN DE SALUD
  int sh;// chatgpt esto es para el ESTADO DEL INMUEBLE
  String familyId;

  Member({
    this.idm = 0,
    required this.name,
    required this.surname,
    required this.kid,
    required this.nid,
    required this.rela,
    required this.gen,
    required this.age,
    required this.et,
    required this.heal,
    required this.aheal,
    required this.sh,
    required this.familyId,
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
      sh:data['sh'],
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
      'sh':sh,
      'familyId': familyId,
    };
  }

  save() async {
    print("Member");
    //await ((idm > 0) ? update(toMap()) : create(toMap()));
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