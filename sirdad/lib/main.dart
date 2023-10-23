import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sirdad/getters/miembro_model.dart';
import 'package:sirdad/provider/members_provider.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/format_widget.dart';
import 'package:sirdad/widget/login_widget.dart';
import 'package:sirdad/widget/miembro_widget.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => miembroModel),
        ChangeNotifierProvider(create: (_) => familyModel),
        ChangeNotifierProvider(create: (_) => Members_Provider()),
        ChangeNotifierProvider(create: (_) => EventModel),
        // ChangeNotifierProvider(create: (_) => )

        //Colocar aquí todos los ChangeNotifierProvider de los modelos que se van a usar
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
          home: const LoginScreen()
          //const FormatWidget()
          // ChangeNotifierProvider(
          //   create: (context) => familyModel,
          //   child: const FormatWidget(),

          // )
          ),
    );
  }
}