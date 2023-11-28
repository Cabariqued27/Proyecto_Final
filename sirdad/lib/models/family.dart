import 'package:sirdad/services/crud.dart';
import 'package:sirdad/services/tables.dart';

class Family extends Crud {
  String idf;
  String barrio;
  String address;
  int phone;
  String date;
  String jefe;
  String eventId;

  Family({
    this.idf = '',
    required this.barrio,
    required this.address,
    required this.phone,
    required this.date,
    required this.jefe,
     this.eventId='este',
  }) : super(familyTable);

  @override
  String toString() {
    return '\n Id: $idf barrio: $barrio phone: $phone \n';
  }

  Family toObject(Map<dynamic, dynamic> data) {
    return Family(
        idf: data['idf'],
        barrio: data['barrio'],
        address: data['address'],
        phone: data['phone'],
        date: data['date'],
        jefe: data['jefe'],
        eventId: data['eventId']);
  }

  /*Map<String, dynamic> toMap() {
    return {
      'idf': idf > 0 ? idf : null,
      'barrio': barrio,
      'address': address,
      'phone': phone,
      'date': date,
      'jefe': jefe,
      'eventId': eventId,
    };
  }*/

  save() async {
    print("Family");
    // await((idf > 0) ? update(toMap()) : create(toMap()));
  }

  /*remove() async {
    await delete(idf);
  }*/

  Future<List<Family>> getFamilys() async {
    var resultf = await query('SELECT * FROM $familyTable');
    return _getListObject(resultf);
  }

  List<Family> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
