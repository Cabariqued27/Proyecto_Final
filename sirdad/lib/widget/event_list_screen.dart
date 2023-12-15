import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_list_screen.dart';
import '../getters/event_model.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 30),
                Text(
                  'Eventos Registrados',
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
            child: Consumer<EventData>(
              builder: (context, eventData, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventData.events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.orange, // Establece el color de fondo a naranja
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text('Nombre del Evento: ${eventData.events[index].name}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Descripción: ${eventData.events[index].description}'),
                              Text('Fecha: ${eventData.events[index].date}'),
                            ],
                          ),
                          onTap: () {
                            String eventId = eventData.events[index].id;
                            print(eventId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FamilyListScreen(),
                              ),
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
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
