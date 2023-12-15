import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_list_screen.dart';
import '../getters/event_model.dart';



EventData eventData = EventData();

void main() {
  runApp(const MyEventListScreen());
}

class MyEventListScreen extends StatelessWidget {
  const MyEventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listado de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const EventListScreenw(),
    );
  }
}

class EventListScreenw extends StatefulWidget {
  const EventListScreenw({super.key});

  @override
  _EventListScreen createState() => _EventListScreen();
}

class _EventListScreen extends State <EventListScreenw> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos Registrados'),
      ),
      body: Consumer<EventData>(
        builder: (context, eventData, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: eventData.events.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(
                      'Nombre del Evento: ${eventData.events[index].name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Descripción: ${eventData.events[index].description}'),
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
              );
            },
          );
        },
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
