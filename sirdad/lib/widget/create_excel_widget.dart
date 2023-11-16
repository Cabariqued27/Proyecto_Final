import 'package:flutter/material.dart';
import 'package:sirdad/widget/filem.dart';
import 'filem.dart';

FileM fileM = FileM();

class Excel extends StatelessWidget {
  const Excel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Personas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ExcelPage(),
    );
  }
}

class ExcelPage extends StatefulWidget {
  @override
  _ExcelPageState createState() => _ExcelPageState();
}

class _ExcelPageState extends State<ExcelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDAN"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => FileM.Test(context),
              child: Text('Generate Excel'),
            ),
          ],
        ),
      ),
    );
  }
}
