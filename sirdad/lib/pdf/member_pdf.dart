import 'dart:io';

import 'package:flutter/material.dart';
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
      'NOMBRES',
      'APELLIDOS',
      'TIPO DE DOCUMENTO',
      'NÚMERO DE DOCUMENTO',
      'PARENTESCO CON EL JEFE DE HOGAR',
      'GÉNERO',
      'EDAD',
      'ETNIA',
      'ESTADO DE SALUD',
      'AFILIACIÓN AL REGIMEN DE SALUD',
      'UBICACIÓN DEL INMUEBLE',
      'PROPIEDAD DEL INMUEBLE',
      'ESTADO DEL INMUEBLE',
      'AHE ALIM.',
      'AHE NO ALM',
      'MAT REHAB',
      'SUB ARRIEN',
    ],

    [
      'Dato 1',
      'Dato 2',
      'Dato 3',
      'Dato 4',
      'Dato 5',
      'Dato 6',
      'Dato 7',
      'Dato 8',
      'Dato 9',
      'Dato 10',
      'Dato 11',
      'Dato 12',
      'Dato 13',
      'Dato 14',
      'Dato 15',
      'Dato 16',
    ],
    [
      'Dato 17',
      'Dato 18',
      'Dato 19',
      'Dato 20',
      'Dato 21',
      'Dato 22',
      'Dato 23',
      'Dato 24',
      'Dato 25',
      'Dato 26',
      'Dato 27',
      'Dato 28',
      'Dato 29',
      'Dato 30',
      'Dato 31',
      'Dato 32',
    ],
    // Puedes agregar más filas según sea necesario
  ];

    // Agregar filas con los datos de los miembros
  for (var member in members) {
    data.add([
      member.name ?? '',
      member.surname ?? '',
      member.kid?.toString() ?? '',
      member.nid?.toString() ?? '',
      member.rela?.toString() ?? '',
      member.gen ?? '',
      member.age?.toString() ?? '',
      member.et?.toString() ?? '',
      member.heal?.toString() ?? '',
      member.aheal?.toString() ?? '',
      '', // Ubicación del inmueble
      '', // Propiedad del inmueble
      '', // AHE ALIM.
      '', // AHE NO ALM
      '', // MAT REHAB
      '', // SUB ARRIEN
    ]);
  }

  // Crear la tabla con los datos estáticos
  final table = pw.Table(
    columnWidths: {
      for (var i = 0; i < data[0].length; i++) i: pw.FixedColumnWidth(120),
    },
    border: pw.TableBorder.all(),
    children: <pw.TableRow>[
      for (var row in data)
        pw.TableRow(
          children: <pw.Widget>[
            for (var cell in row)
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(cell),
              ),
          ],
        ),
    ],
  );

  // Envolver la tabla en un FittedBox para ocupar todo el espacio disponible
  //no estoy utilizando esto por ahora
  final fittedTable = pw.FittedBox(
    child: pw.Container(
      child: table,
    ),
  );

  // Agregar la tabla al documento PDF
  // Rotar la tabla y otros elementos en el documento PDF
  // Agregar la tabla al documento PDF rotada dentro de una SinglePage
  // Agregar la tabla al documento PDF rotada
  // Establecer el tamaño de la página en orientación horizontal
  final pageHeight = PdfPageFormat.a4.width;
  final pageWidth = PdfPageFormat.a4.height;

  // Agregar la tabla al documento PDF rotada
  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Transform.rotate(
        angle: -90 *
            3.141592653589793 /
            180, // Rotar 90 grados en sentido antihorario
        child: pw.Center(
          child: pw.Container(
            // Establecer el tamaño para mostrar el contenido rotado dentro de la página
            width: pageWidth,
            height: pageHeight,
            child: pw.FittedBox(
              fit: pw.BoxFit.contain,
              child: pw.Container(
                child:
                    fittedTable, // Agregar otros elementos aquí si es necesario
              ),
            ),
          ),
        ),
      );
    },
  ));

  //para enviar el pdf al internal
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
} 

//hasta aquí llega generate PDF

// pw.Widget _buildTable(List<Member> members) {
//   return pw.Container(
//     height: 600,
//     width: 1500, // Ajusta según tus necesidades
//     child: pw.Table(
//       border: pw.TableBorder.all(),
//       columnWidths: {
//         0: pw.FixedColumnWidth(300), // Ancho para la columna 'Nombre'
//         1: pw.FixedColumnWidth(
//             300), // Ancho para la columna 'Tipo de documento'
//         2: pw.FixedColumnWidth(
//             300), // Ancho para la columna 'Numero de documento'
//         3: pw.FixedColumnWidth(
//             300), // Ancho para la columna 'Parentesco con el jefe de Hogar'
//         4: pw.FixedColumnWidth(300), // Ancho para la columna 'Genero'
//         5: pw.FixedColumnWidth(300), // Ancho para la columna 'Edad'
//         6: pw.FixedColumnWidth(300), // Ancho para la columna 'Etnia'
//         7: pw.FixedColumnWidth(300), // Ancho para la columna 'Estado de salud'
//         8: pw.FixedColumnWidth(
//             300), // Ancho para la columna 'Afiliacion al regimen de salud'
//         9: pw.FixedColumnWidth(
//             300), // Ancho para la columna 'Estado del Inmueble'
//       },
//       children: [
//         pw.TableRow(
//           children: [
//             // Headers de la tabla

//             pw.Text('Nombre'),
//             pw.Text('Apellido'),
//             pw.Text('Tipo de documento'),
//             pw.Text('Numero de documento'),
//             pw.Text('Parentesco con el jefe de Hogar'),
//             pw.Text('Genero'),
//             pw.Text('Edad'),
//             pw.Text('Etnia'),
//             pw.Text('Estado de salud'),
//             pw.Text('Afiliacion al regimen de salud'),
//             pw.Container(
//               padding: pw.EdgeInsets.symmetric(
//                   horizontal: 100,
//                   vertical:
//                       5), // Ajusta el padding para cambiar la altura visual de las celdas
//             ),
//           ],
//         ),
//         for (var member in members)
//           pw.TableRow(
//             children: [
//               pw.Text('${member.name} ${member.surname}'),
//               pw.Text('${member.kid}'),
//               pw.Text('${member.nid}'),
//               pw.Text('${member.rela}'),
//               pw.Text('${member.gen}'),
//               pw.Text('${member.age}'),
//               pw.Text('${member.et}'),
//               pw.Text('${member.heal}'),
//               pw.Text('${member.aheal}'),
//               pw.Text('${member.familyId}'),
//               // pw.Text('${member.familyId}'),
//             ],
//           ),
//       ],
//     ),
//   );
// }

// pw.Widget _buildInfoBox(String label) {
//   return pw.Container(
//     width: 100, // Adjust the width as needed
//     height: 60, // Adjust the height as needed
//     child: pw.Column(
//       mainAxisAlignment: pw.MainAxisAlignment.center,
//       children: [
//         pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//       ],
//     ),
//     decoration: pw.BoxDecoration(border: pw.Border.all()),
//   );
// }

// pw.Widget _buildInfoBox1(String label) {
//   return pw.Container(
//     width: 160, // Adjust the width as needed
//     height: 50, // Adjust the height as needed
//     child: pw.Column(
//       mainAxisAlignment: pw.MainAxisAlignment.center,
//       children: [
//         pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//       ],
//     ),
//     decoration: pw.BoxDecoration(border: pw.Border.all()),
//   );
// }

// pw.Widget _buildInfoBoxWithText(String title, String text) {
//   return pw.Container(
//     width: 80, // Adjust the width as needed
//     height: 200, // Adjust the height as needed
//     child: pw.Column(
//       mainAxisAlignment: pw.MainAxisAlignment.start,
//       children: [
//         pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//         pw.SizedBox(height: 4),
//         pw.Text(text),
//       ],
//     ),
//     decoration: pw.BoxDecoration(border: pw.Border.all()),
//   );
// }
