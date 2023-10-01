
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/presentation/widget/miembro_widget.dart';




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
          create: (context) => miembroModel,
          child: const Miembro_Widget(),
        )

        //const FamilyChiefWidget(),printN
        );
  }
}
