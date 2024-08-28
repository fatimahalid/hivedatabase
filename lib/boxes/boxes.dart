

import 'package:hive/hive.dart';

import '../models/notes_models.dart';

class Boxes{ //jitny bhi banae hian boxes yahan unhhain easily get kr lain gy

  static Box<NotesModels> getData()=> Hive.box('notes');
}