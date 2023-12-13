import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';

//tanto el member como Family son de models
Future<void> generatePDF(List<Member> members, List<Family> familys,
    Function(String) showMessage) async {
  final pdf = pw.Document();
  // Crear una lista de filas para la tabla
  List<List<String>> data = [
    [
      'Nombres',
      'Apellidos',
      'Tipo de documento',
      'Número de documento',
      'Parentesco con el jefe de hogar',
      'Genero',
      'Edad',
      'Etnia',
      'Estado de Salud',
      'Afiliación al Regimen de salud'
    ],
    ['Dato 1', 'Dato 2', 'Dato 3'],
    ['Dato 4', 'Dato 5', 'Dato 6'],
    // Puedes agregar más filas según sea necesario
  ];
  
   // Especificar las dimensiones de las columnas
  const List<double> columnWidths = [120, 120, 120, 120, 120];

  // Crear una lista de TableColumnWidths usando los anchos especificados
  List<pw.TableColumnWidth> tableColumnWidths =
      List<pw.TableColumnWidth>.generate(columnWidths.length,
          (index) => pw.FixedColumnWidth(columnWidths[index]));

  // Construir la tabla con dimensiones personalizadas para las columnas
  final table = pw.Table(
    columnWidths: pw.TableColumnWidth.fromList(tableColumnWidths),
    border: pw.TableBorder.all(),
    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
    rowDecoration: pw.BoxDecoration(color: PdfColors.grey100),
    cellAlignment: pw.Alignment.center,
    children: data.map((List<String> row) {
      return pw.Row(
        children: row.map((String cell) {
          return pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(cell),
          );
        }).toList(),
      );
    }).toList(),
  );


  final status = await Permission.storage.status;
  if (status.isGranted) {
    final directory = await getExternalStorageDirectory();
    final pdfFilePath = '${directory!.path}/Download/miembros.pdf';

    if (!await Directory('${directory.path}/Download').exists()) {
      await Directory('${directory.path}/Download').create(recursive: true);
    }

    await File(pdfFilePath).writeAsBytes(await pdf.save());

    // Mostrar el mensaje utilizando ScaffoldMessengerState
    showMessage('PDF generado en $pdfFilePath');
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('PDF generado con éxito en $pdfFilePath'),
    // ));
  } else {
    await Permission.storage.request();
    generatePDF(members, familys, showMessage);
  }
} //hasta aquí llega generate PDF

pw.Widget _buildTable(List<Member> members) {
  return pw.Container(
    height: 600,
    width: 1500, // Ajusta según tus necesidades
    child: pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: pw.FixedColumnWidth(300), // Ancho para la columna 'Nombre'
        1: pw.FixedColumnWidth(
            300), // Ancho para la columna 'Tipo de documento'
        2: pw.FixedColumnWidth(
            300), // Ancho para la columna 'Numero de documento'
        3: pw.FixedColumnWidth(
            300), // Ancho para la columna 'Parentesco con el jefe de Hogar'
        4: pw.FixedColumnWidth(300), // Ancho para la columna 'Genero'
        5: pw.FixedColumnWidth(300), // Ancho para la columna 'Edad'
        6: pw.FixedColumnWidth(300), // Ancho para la columna 'Etnia'
        7: pw.FixedColumnWidth(300), // Ancho para la columna 'Estado de salud'
        8: pw.FixedColumnWidth(
            300), // Ancho para la columna 'Afiliacion al regimen de salud'
        9: pw.FixedColumnWidth(
            300), // Ancho para la columna 'Estado del Inmueble'
      },
      children: [
        pw.TableRow(
          children: [
            // Headers de la tabla

            pw.Text('Nombre'),
            pw.Text('Apellido'),
            pw.Text('Tipo de documento'),
            pw.Text('Numero de documento'),
            pw.Text('Parentesco con el jefe de Hogar'),
            pw.Text('Genero'),
            pw.Text('Edad'),
            pw.Text('Etnia'),
            pw.Text('Estado de salud'),
            pw.Text('Afiliacion al regimen de salud'),
            pw.Container(
              padding: pw.EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical:
                      5), // Ajusta el padding para cambiar la altura visual de las celdas
            ),
          ],
        ),
        for (var member in members)
          pw.TableRow(
            children: [
              pw.Text('${member.name} ${member.surname}'),
              pw.Text('${member.kid}'),
              pw.Text('${member.nid}'),
              pw.Text('${member.rela}'),
              pw.Text('${member.gen}'),
              pw.Text('${member.age}'),
              pw.Text('${member.et}'),
              pw.Text('${member.heal}'),
              pw.Text('${member.aheal}'),
              pw.Text('${member.familyId}'),
              // pw.Text('${member.familyId}'),
            ],
          ),
      ],
    ),
  );
}

pw.Widget _buildInfoBox(String label) {
  return pw.Container(
    width: 100, // Adjust the width as needed
    height: 60, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
}

pw.Widget _buildInfoBox1(String label) {
  return pw.Container(
    width: 160, // Adjust the width as needed
    height: 50, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
}

pw.Widget _buildInfoBoxWithText(String title, String text) {
  return pw.Container(
    width: 80, // Adjust the width as needed
    height: 200, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 4),
        pw.Text(text),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
}
