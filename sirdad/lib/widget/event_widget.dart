import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/widget/family_widget.dart';

import '../getters/event_model.dart';
import '../models/event.dart';

EventData EventModel = EventData();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.reference().child('events');
  }

  Future<void> _addEvent(EventData eventData) async {
    if (_formKey.currentState!.validate()) {
      String eventName = _eventNameController.text;
      String eventDescription = _descriptionController.text;
      String eventDate = _dateController.text;

      Event newEvent = Event(
        name: eventName,
        description: eventDescription,
        date: eventDate,
      );

      eventData.addEvent(newEvent);

      _eventNameController.clear();
      _descriptionController.clear();
      _dateController.clear();

      // Guardar el evento en Firebase Realtime Database
      dbRef.push().set({
        'name': eventName,
        'description': eventDescription,
        'date': eventDate,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Eventos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(labelText: 'Nombre del Evento'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre para el evento.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration:
                        InputDecoration(labelText: 'Descripción del Evento'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa una descripción para el evento.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Fecha del Evento'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa una fecha para el evento.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addEvent(context.read<EventData>());
                    },
                    child: Text('Agregar Evento'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Eventos Registrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<EventData>(
              builder: (context, eventData, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventData.events.length,
                  itemBuilder: (context, index) {
                    return Card(
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
                          
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FamilyWidget()),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


