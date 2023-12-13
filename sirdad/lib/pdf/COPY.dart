import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';

//tanto el member como Family son de models
Future<void> generatePDF(List<Member> members, List<Family> familys,
    Function(String) showMessage) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Transform.rotate(
          angle: 90 * 3.1415926535 / 180,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(10),
                margin: pw.EdgeInsets.only(bottom: 10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Text(
                  '  Evaluacion de daños y analisis de necesidades (EDAN)',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 16),
                ),
              ),
              pw.Row(
                children: [
                  pw.Container(
                    width: 100,
                    height: 40,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('NGRD'),
                      ],
                    ),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                  ),
                  pw.Text(
                    'Gestion manejo de desastres',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 15),
                  ),
                  pw.Container(
                    width: 120,
                    height: 40,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Codigo: FR-1703-SMD-08'),
                      ],
                    ),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                  ),
                  pw.Container(
                    width: 80,
                    height: 40,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('version.01'),
                      ],
                    ),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                  ),
                ],
              ),
              pw.Container(
                height: 120, // Adjust the height as needed
                width: 20, // Adjust the width as needed
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Barrio:soledad'),
                    _buildInfoBox('Direccion:cra 25'),
                    _buildInfoBox('Celular: 3008000697'),
                    _buildInfoBox('Fecha: 12/12/23'),
                    _buildInfoBox('Firma del Jefe: Luis diaz'),
                  ],
                ),
              ),
              _buildTable(members),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoBoxWithText('Tipo de documento',
                      '1.registro civil 2.tarjeta de identidad 3.cedula de ciudadania 4.cedula de extrajeria 5.indocumentado 6.no sabe/ no responde'),
                  _buildInfoBoxWithText('Parentesco con el jefe de hogar',
                      '1. jefe de hogar 2.esposo(a) 3.hijo(a) 4.primo(a) 5.tio(a) 6.nieto(a) 7.suegro(a) 8.yerno/nuera'),
                  _buildInfoBoxWithText('Etnia',
                      '1.afrocolombiano 2.indigena 3.Gitano 4.Razial 5.Otro 6.sin informacion'),
                  _buildInfoBoxWithText('Estado de salud',
                      ' 1.Requiere asistencia 2.no requiere asistencia medica'),
                  _buildInfoBoxWithText('Afiliacion al regimen de salud',
                      '1.contributivo 2.subsidio 3.sin afilicion'),
                  _buildInfoBoxWithText('Estado del Inmueble',
                      ' 1.habitable 2.no habitable 3.destruida'),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Container(
                child: pw.Row(
                  children: [
                    _buildInfoBox1('Elaborado por : Hermmann'),
                    _buildInfoBox1('Entidad operativa: jack'),
                    _buildInfoBox1('Observaciones: hola'),
                  ],
                ),
                decoration: pw.BoxDecoration(border: pw.Border.all()),
              ),
              pw.Container(
                child: pw.Row(
                  children: [
                    _buildInfoBox1('Vo.Bo. CMGRD :   '),
                    _buildInfoBox1('Presidente CMGRD :   '),
                    _buildInfoBox1('Vo.Bo. CDGRD:   '),
                  ],
                ),
                decoration: pw.BoxDecoration(border: pw.Border.all()),
              ),
            ],
          ),
        );
      },
    ),
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
        1: pw.FixedColumnWidth(300), // Ancho para la columna 'Tipo de documento'
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