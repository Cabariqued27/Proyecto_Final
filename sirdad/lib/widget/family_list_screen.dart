import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/family_model.dart';
import 'package:sirdad/widget/MembersListScreen.dart';
import 'package:sirdad/widget/family_widget.dart';

class FamilyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Familias Registradas'),
      ),
      body: Consumer<FamilyData>(
        builder: (context, familyData, child) {
          return ListView.builder(
            itemCount: familyData.familys.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text('Barrio: ${familyData.familys[index].barrio}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dirección: ${familyData.familys[index].address}'),
                      Text(
                          'Teléfono: ${familyData.familys[index].phone.toString()}'),
                      Text('Fecha: ${familyData.familys[index].date}'),
                      Text(
                          'Jefe de familia: ${familyData.familys[index].jefe}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MembersListScreen()),
                    );
                    String familyId = familyData.familys[index].idf;
                    print(familyId);
                    // Puedes agregar aquí la lógica de navegación si es necesario
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FamilyWidget(
                      eventIdf: '',
                    )),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
