import '../services/crud.dart';
import '../services/tables.dart';

class Volunteer extends Crud {
  int idv;
  String namev;
  int nidv;
  int phonev;
  String ong;
  String sign;
  String news;

  Volunteer({
    this.idv = 0,
    this.namev = '',
    this.nidv = 0,
    this.phonev = 0,
    this.ong = '',
    this.sign = '',
    this.news = '',
  }) : super(volunteerTable);

  @override
  String toString() {
    return '\n Id: $idv Nombre: $namev Edad: $phonev \n';
  }

  Volunteer toObject(Map<dynamic, dynamic> data) {
    return Volunteer(
      idv: data['idv'],
      namev: data['namev'],
      nidv: data['nidv'],
      phonev: data['phonev'],
      ong: data['ong'],
      sign: data['sign'],
      news: data['news'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idv': idv > 0 ? idv : null,
      'namev': namev,
      'nidv': nidv,
      'phonev': phonev,
      'ong': ong,
      'sign': sign,
      'news': news,
    };
  }

  save() async {
    print("Volunteer");
    await ((idv > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(idv);
  }

  Future<List<Volunteer>> getVolunteers() async {
    var resultf = await query('SELECT * FROM $volunteerTable');
    return _getListObject(resultf);
  }

  List<Volunteer> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
