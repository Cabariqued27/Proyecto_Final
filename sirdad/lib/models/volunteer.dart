import '../services/crud.dart';
import '../services/tables.dart';

class Volunteer extends Crud {
  String idv;
  String namev;
  String password;
  int nidv;
  int phonev;
  String ong;
  String sign;
  String news;
  bool hasAccess;
  bool isAdmid;

  Volunteer({
    this.idv = '',
    this.namev = '',
    this.password = '',
    this.nidv = 0,
    this.phonev = 0,
    this.ong = '',
    this.sign = '',
    this.news = '',
    this.hasAccess = false,
    this.isAdmid = false,
  }) : super(volunteerTable);

  @override
  String toString() {
    return '\n Id: $idv Nombre: $namev Edad: $phonev \n';
  }

  Volunteer toObject(Map<dynamic, dynamic> data) {
    return Volunteer(
        idv: data['idv'],
        namev: data['namev'],
        password: data['password'],
        nidv: int.parse(data['nidv']),
        phonev: int.parse(data['phonev']),
        ong: data['ong'],
        sign: data['sign'],
        news: data['news'],
        hasAccess: data[false],
        isAdmid: data[false]);
        
  }

  /*Map<String, dynamic> toMap() {
    return {
      'idv': idv > 0 ? idv : null,
      'namev': namev,
      'nidv': nidv,
      'phonev': phonev,
      'ong': ong,
      'sign': sign,
      'news': news,
      'hasAccess': hasAccess,
      'isAmid': isAdmid,
    };
  }*/


  

   save() async {
     print("Volunteer");
     // await ((idv > 0) ? update(toMap()) : create(toMap()));
   }


  /*remove() async {
    await delete(idv);
  }*/

  Future<List<Volunteer>> getVolunteers() async {
    var resultf = await query('SELECT * FROM $volunteerTable');
    return _getListObject(resultf);
  }

  List<Volunteer> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
