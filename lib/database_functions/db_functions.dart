import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabaseFunctions extends ChangeNotifier {
  static late Isar isar;

  //intialisation of the database
  static Future<void> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteModelSchema],
      directory: dir.path,
    );
  }

  //list of notes
  final List<NoteModel> currentNotes = [];

  //add data
  Future<void> addNote(String noteFromUser) async {
    //create a new note object
    final newNote = NoteModel()..text = noteFromUser;

    //saving to database
    await isar.writeTxn(() => isar.noteModels.put(newNote));

    //re-update the list of notes
    fetchNotes();
  }

  //get data
  Future<void> fetchNotes() async {
    List<NoteModel> fetchedNotes = await isar.noteModels.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //update data
  Future<void> updateNote(int id, String updatedNote) async {
    //finding the text from db
    final existingNote = await isar.noteModels.get(id);
    if (existingNote != null) {
      existingNote.text = updatedNote;
      //saving to database
      await isar.writeTxn(() => isar.noteModels.put(existingNote));
      //re-update the list of notes
      fetchNotes();
    }
  }

  //delete data
  Future<void> deleteNotes(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    fetchNotes();
  }
}
