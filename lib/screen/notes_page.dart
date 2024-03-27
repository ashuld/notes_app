import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/component/drawer.dart';
import 'package:notes_app/component/note_tile.dart';
import 'package:notes_app/database_functions/db_functions.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController noteController = TextEditingController();
  //create new Note
  void createNote() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: TextField(
            controller: noteController,
          ),
          actions: [
            MaterialButton(
              child: const Text('Add Note'),
              onPressed: () {
                var text = noteController.text.trim();
                if (text.isNotEmpty) {
                  context
                      .read<NoteDatabaseFunctions>()
                      .addNote(noteController.text);
                  //disable alert dialog
                  Navigator.of(context).pop();
                  noteController.clear();
                } else {
                  context.read<NoteDatabaseFunctions>().addNote('New Note');
                }
              },
            )
          ],
        ),
      );

  //fetch note
  void fetchNote() => context.read<NoteDatabaseFunctions>().fetchNotes();

  //update note
  void updateNote(NoteModel note) {
    noteController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: noteController,
        ),
        actions: [
          MaterialButton(
            child: const Text('Update'),
            onPressed: () {
              var text = noteController.text;
              if (text.isNotEmpty) {
                context.read<NoteDatabaseFunctions>().updateNote(note.id, text);
                noteController.clear();
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }

  //delete note
  void deleteNote(NoteModel note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: const Text('Are you sure you want to delete?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                child: const Text('Yes'),
                onPressed: () {
                  context.read<NoteDatabaseFunctions>().deleteNotes(note.id);
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: const Text('No'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    fetchNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // noteDataBase
    final noteDatabase = context.watch<NoteDatabaseFunctions>();

    //current notes
    List<NoteModel> currentNote = noteDatabase.currentNotes;
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Note',
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNote.length,
              itemBuilder: (context, index) {
                //get individual notes
                final note = currentNote[index];
                //list tile ui
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
