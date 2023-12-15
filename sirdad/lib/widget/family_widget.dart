import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sirdad/getters/family_model.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_list_screen.dart';

FamilyData familyData = FamilyData();

void main() {
  runApp(FamilyWidget(eventIdf: ''));
}

class FamilyWidget extends StatelessWidget {
  final String eventIdf;

  FamilyWidget({required this.eventIdf});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Familias',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(eventIdf: eventIdf),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String eventIdf;
  MyHomePage({required this.eventIdf});

  @override
  _MyHomePageState createState() => _MyHomePageState(eventIdf);
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _barrioController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _headOfFamilyController = TextEditingController();
  late DatabaseReference dbRef;
  final String eventIdf;

  _MyHomePageState(this.eventIdf);

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('familys');
    // Establecer la fecha actual como valor por defecto
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _getFamilysFromCache();
  }

  Future<void> _getFamilysFromCache() async {
    // Llamar a la función getFamilysFromCache de tu modelo de datos
    await familyData.getFamilysByEventId(eventIdf);
  }

  Future<void> _addFamily(FamilyData familyData) async {
    if (_formKey.currentState!.validate()) {
      String familyBarrio = _barrioController.text;
      String familyAddress = _addressController.text;
      int familyPhone = int.parse(_phoneController.text);
      String familyDate = _dateController.text;
      String familyHead = _headOfFamilyController.text;

      Family newFamily = Family(
        barrio: familyBarrio,
        address: familyAddress,
        phone: familyPhone,
        date: familyDate,
        jefe: familyHead,
        eventId: eventIdf,
      );

      //familyData.addFamily(newFamily);

      _barrioController.clear();
      _addressController.clear();
      _phoneController.clear();
      _headOfFamilyController.clear();

      // Save the family in Firebase Realtime Database
      dbRef.push().set({
        'barrio': newFamily.barrio,
        'address': newFamily.address,
        'phone': newFamily.phone,
        'date': newFamily.date,
        'jefe': newFamily.jefe,
        'eventId': newFamily.eventId,
      });
    }
  }

  Future<void> _generatePDF(List<Family> familys) async {
    //este Family es del CRUD de models
    final pdf = pw.Document();

    // Generate the content of the PDF from the list of familys
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: familys
                .map(
                  (family) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Barrio: ${family.barrio}'),
                      pw.Text('Address: ${family.address}'),
                      pw.Text('Phone: ${family.phone.toString()}'),
                      pw.Text('Date: ${family.date}'),
                      pw.Text('Jefe de familia: ${family.eventId}'),
                      pw.SizedBox(height: 16),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );

    // Get the document directory on the device
    final status = await Permission.storage.status;
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final pdfFilePath = '${directory!.path}/Download/miembros.pdf';

      if (!await Directory('${directory.path}/Download').exists()) {
        await Directory('${directory.path}/Download').create(recursive: true);
      }

      await File(pdfFilePath).writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PDF generado con éxito en $pdfFilePath'),
      ));
    } else {
      await Permission.storage.request();
      _generatePDF(familys);
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
          title: Text('Gestión de Familias'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navegar a FamilyWidget y pasar el ID del evento
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  )); // Esto llevará de regreso a EventWidget
            },
          ),
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
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _barrioController,
                        decoration: InputDecoration(labelText: 'Barrio'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa el barrio.';
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
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Dirección'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa la dirección.';
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
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Teléfono'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa el teléfono.';
                          }
                          if (int.tryParse(value) == null) {
                            return 'El teléfono debe ser un número.';
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
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(labelText: 'Fecha'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa la fecha.';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _headOfFamilyController,
                        decoration:
                            InputDecoration(labelText: 'Jefe de familia'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa el jefe de familia.';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addFamily(context.read<FamilyData>());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FamilyListScreen()),
                        );
                      },
                      child: Text('Agregar Familia'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
