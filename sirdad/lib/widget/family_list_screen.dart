// FamilyListScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/family_model.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/MembersListScreen.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/member_widget.dart';

class FamilyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.orange,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16),
                Text(
                  'Familias Registradas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<FamilyData>(
              builder: (context, familyData, child) {
                return ListView.builder(
                  itemCount: familyData.familys.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.orange,
                      child: Card(
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
                              Text('Jefe de familia: ${familyData.familys[index].jefe}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MembersListScreen()),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FamilyWidget(eventIdf: '',)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
