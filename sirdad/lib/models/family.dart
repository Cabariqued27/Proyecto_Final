import 'package:sirdad/services/crud.dart';
import 'package:sirdad/services/tables.dart';

class Family extends Crud {
  int id;
  String barrio;
  String address;
  int phone;
  String date;
  int eventId;

  Family({
    this.id=0,
    this.barrio='',
    this.address='',
    this.phone=0,
    this.date='',
    this.eventId=0,
  }):super(familyTable);

  @override
  String toString(){
    return '\n Id: $id barrio: $barrio phone: $phone \n';
  }

  Family toObject(Map<dynamic,dynamic>data){
    return Family(
     id: data['id'],
     barrio: data['barrio'],
     address: data['address'],
     phone: data['phone'],
     date: data['date'],
     eventId: data['eventId']);
     }

  Map<String, dynamic> toMap() {
    return {
      'id': id>0?id:null,
      'barrio': barrio,
      'address': address,
      'phone': phone,
      'date': date,
      'eventId': eventId,
    };
  }

  save()async{
    return await((id>0)?update(toMap()):create(toMap()));
  }

  remove()async{
    await delete(id);
  }

  Future<List<Family>>getFamilys()async{
    var result = await query('SELECT * FROM $familyTable');
    return _getListObject(result);
  }

  List<Family> _getListObject(parsed){
    return(parsed as List).map((map) => toObject(map)).toList();
  }
  

  
}





