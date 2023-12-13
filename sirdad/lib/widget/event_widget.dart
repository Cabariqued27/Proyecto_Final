import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sirdad/widget/event_list_screen.dart';
import 'package:sirdad/widget/family_list_screen.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'dart:io';
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
    dbRef = FirebaseDatabase.instance.ref().child('events');

    // Establecer la fecha actual como valor por defecto
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _getEventsFromCache();
    print('Datos obtenidos correctamente.');
  }

  Future<void> _getEventsFromCache() async {
    // Llamar a la función getEventsFromCache de tu modelo de datos
    await EventModel.getEventsFromCache();
  }

  Future<void> _addEvent(EventData eventData) async {
    if (_formKey.currentState!.validate()) {
      String eventName = _eventNameController.text;
      String eventDescription = _descriptionController.text;
      String eventDate = _dateController.text;
      /*Event newEvent = Event(
        name: eventName,
        description: eventDescription,
        date: now,
      );*/

      //eventData.addEvent(newEvent);

      _eventNameController.clear();
      _descriptionController.clear();

      // Guardar el evento en Firebase Realtime Database
      dbRef.push().set({
        'name': eventName,
        'description': eventDescription,
        'date': eventDate,
      });

      // Llamar a la función geteventsfb para actualizar la lista de eventos
      await eventData.getEventsFromCache();
    }
  }

  Future<void> _generatePDF(List<Event> events) async {
    // Verificar y solicitar permiso de escritura en el almacenamiento externo
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pdf = pw.Document();

      // Generar el contenido del PDF a partir de la lista de eventos
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              children: events
                  .map(
                    (event) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Nombre del Evento: ${event.name}'),
                        pw.Text('Descripción: ${event.description}'),
                        pw.Text('Fecha: ${event.date}'),
                        pw.SizedBox(height: 16),
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
      );

      // Obtener el directorio de almacenamiento externo
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        // Crear el archivo PDF en el directorio de almacenamiento externo
        final pdfFilePath = '${directory.path}/eventos.pdf';

        // Escribir el contenido del PDF en el archivo
        await File(pdfFilePath).writeAsBytes(await pdf.save());

        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PDF generado con éxito en $pdfFilePath'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No se pudo acceder al almacenamiento externo.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Se requieren permisos de almacenamiento para guardar el PDF.'),
      ));
    }
  }




@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.orange,
        width: 10.0,
      ),
    ),
    child: Scaffold(
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _eventNameController,
                      decoration: InputDecoration(labelText: 'Nombre del Evento'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un nombre para el evento.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Descripción del Evento'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa una descripción para el evento.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(labelText: 'Fecha del Evento'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa una fecha para el evento.';
                        }
                        return null;
                      },
                      readOnly: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addEvent(context.read<EventData>());
                      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventListScreen()),
    );
                    },
                    child: Text('Agregar Evento'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventListScreen()),
    );
                    },
                    child: Text('Ver lista de evento'),
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
                          String eventId = eventData.events[index].id;
                          print(eventId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FamilyListScreen(),
                            ),
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
    ),
  );
}




}
