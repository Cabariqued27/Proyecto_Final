<<<<<<< Updated upstream
import 'dart:html';
=======
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/widget/miembro_widget.dart';
import 'models/event.dart';
>>>>>>> Stashed changes

import 'package:flutter/material.dart';
import 'package:sirdad/model/sharedData.dart';

import 'package:sirdad/widgets/add_member.dart';

void main() {
  final sharedData = SharedData();
  runApp(MyApp(sharedData: sharedData));
}

class MyApp extends StatelessWidget {
  final SharedData sharedData;
  const MyApp({super.key, required this.sharedData});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.                         
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< Updated upstream
      home: //const MyHomePage(title: 'SIRDAD'),
          //AQUÍ SE HABRE LO DEL FORMATO PARA UN MIEMBRO DE LA FAMILIA
          AddMemberWidget(
              sharedData:
                  sharedData), //De sharedData recibiras el objeto con todos sus atributos
      //con sus valores actualizados
=======
      home: ChangeNotifierProvider(
          create: (context) => miembroModel,
          child: Miembro_Widget(),
        )
      //const MyHomePage(title: 'SIRDAD'),
>>>>>>> Stashed changes
    );
  }
}
