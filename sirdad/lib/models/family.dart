import 'package:sirdad/services/crud.dart';
import 'package:sirdad/services/tables.dart';

class Family extends Crud {
  int idf;
  String barrio;
  String address;
  int phone;
  String date;
  int eventId;

  Family({
    this.idf = 0,
    this.barrio = '',
    this.address = '',
    this.phone = 0,
    this.date = '',
    this.eventId = 0,
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
        eventId: data['eventId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'idf': idf > 0 ? idf : null,
      'barrio': barrio,
      'address': address,
      'phone': phone,
      'date': date,
      'eventId': eventId,
    };
  }

  save() async {
    print("Family");
    await ((idf > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(idf);
  }

  Future<List<Family>> getFamilys() async {
    var resultf = await query('SELECT * FROM $familyTable');
    return _getListObject(resultf);
  }

  List<Family> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
