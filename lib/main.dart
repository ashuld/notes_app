import 'package:flutter/material.dart';
import 'package:notes_app/database_functions/db_functions.dart';
import 'package:provider/provider.dart';

import 'screen/notes_page.dart';

Future<void> main() async {
  //database intialization
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabaseFunctions.initDB();
  runApp(ChangeNotifierProvider(
    create: (context) => NoteDatabaseFunctions(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4e515c)),
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}
