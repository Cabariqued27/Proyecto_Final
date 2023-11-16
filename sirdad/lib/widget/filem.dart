import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class FileM {
  static Test(BuildContext context) {
// Create a new Excel document.
    final Workbook workbook = new Workbook();
//Accessing worksheet via index.
    workbook.worksheets[0];
// Save the document.
    final List<int> bytes = workbook.saveAsStream();
    File('CreateExcel.xlsx').writeAsBytes(bytes);
//Dispose the workbook.
    workbook.dispose();
  }
}
