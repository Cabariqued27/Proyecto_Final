import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/event_model.dart';
import 'package:sirdad/widget/acceso_widget.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/login_widget.dart';
import 'package:sirdad/widget/miembro_widget.dart';




void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
        home: ChangeNotifierProvider(
          create: (context) => EventModel,
          child: LoginScreen(),
        
        )

        
        );
  }
}