import 'package:flutter/material.dart';
import 'package:notes_app/database_functions/db_functions.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'screen/notes_page.dart';

Future<void> main() async {
  //database intialization
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabaseFunctions.initDB();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabaseFunctions()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}
