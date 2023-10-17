import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sirdad/getters/miembro_model.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/format_widget.dart';
import 'package:sirdad/widget/miembro_widget.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => miembroModel)],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
          home: const FormatWidget()
          // ChangeNotifierProvider(
          //   create: (context) => familyModel,
          //   child: const FormatWidget(),

          // )
          ),
    );
  }
}
