import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:sirdad/getters/family_model.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/member_widget.dart';



FamilyData FamilyModel = FamilyData();

void main() {
  runApp(FamilyWidget());
}

class FamilyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Familias',
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
  TextEditingController _barrioController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _headOfFamilyController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('familys');
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
        jefe:familyHead, 
        eventId: 'unico',
      );

      familyData.addFamily(newFamily);
      print(familyData.getfamilysfb());

      _barrioController.clear();
      _addressController.clear();
      _phoneController.clear();
      _dateController.clear();
      _headOfFamilyController.clear();

      // Save the family in Firebase Realtime Database
      dbRef.push().set({
        'barrio': familyBarrio,
        'address': familyAddress,
        'phone': familyPhone,
        'date': familyDate,
        'headOfFamily': familyHead,
      });
    }
  }

  Future<void> _generatePDF(List<Family> familys) async {
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
    final output = await getApplicationDocumentsDirectory();

    // Create the PDF file in the document directory
    final pdfFile = File("${output.path}/familys.pdf");

    // Write the content of the PDF to the file
    await pdfFile.writeAsBytes(await pdf.save());

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF generated successfully at ${pdfFile.path}'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Familias'),
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
                    controller: _barrioController,
                    decoration: InputDecoration(labelText: 'Barrio'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el barrio.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Dirección'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la dirección.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
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
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Fecha'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la fecha.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _headOfFamilyController,
                    decoration: InputDecoration(labelText: 'Jefe de familia'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el jefe de familia.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addFamily(context.read<FamilyData>());
                    },
                    child: Text('Agregar Familia'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Get the list of familys from the context
                      List<Family> familys = context.read<FamilyData>().familys;
                      _generatePDF(familys);
                    },
                    child: Text('Generar PDF de Familias'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Familias Registradas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<FamilyData>(
              builder: (context, familyData, child) {
                return ListView.builder(
                  shrinkWrap: true,
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
                            Text('Teléfono: ${familyData.familys[index].phone.toString()}'),
                            Text('Fecha: ${familyData.familys[index].date}'),
                            Text('Jefe de familia: ${familyData.familys[index].eventId}'),
                          ],
                        ),
                        onTap: () {
                          
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MiembroWidget()),
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
