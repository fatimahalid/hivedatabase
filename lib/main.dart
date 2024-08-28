import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/home_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'models/notes_models.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // widget binding ho gai hy is line per
  var directory = await getApplicationDocumentsDirectory(); // doc ki directory mil jae gi
  Hive.init(directory.path); //  (initialize kr dy ga)  // is directory ya folder per ja kr hive files create krna shuru kr dy ga



  Hive.registerAdapter(NotesModelsAdapter());
  await Hive.openBox<NotesModels>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}


