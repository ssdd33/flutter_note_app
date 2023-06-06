import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screnn.dart';
import 'package:flutter_note_app/presentation/notes/compenents/note_item.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'your note',
          style: TextStyle(fontSize: 30),
        ),
        actions: const [
          Icon(Icons.sort),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: state.notes.map((note) => NoteItem(note: note)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditNoteScreen()));

          if (isSaved == true) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
