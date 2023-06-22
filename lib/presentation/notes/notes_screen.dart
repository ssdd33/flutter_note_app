import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screnn.dart';
import 'package:flutter_note_app/presentation/notes/compenents/note_item.dart';
import 'package:flutter_note_app/presentation/notes/compenents/order_section.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              viewModel.onEvent(const ToggleOrderSection());
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.isOrderSectionVisible
                ? OrderSection(
                    noteOrder: state.noteOrder,
                    onOrderChanged: (NoteOrder noteOrder) {
                      viewModel.onEvent(NotesEvent.changeOrder(noteOrder));
                    },
                  )
                : Container(),
          ),
          ...state.notes
              .map((note) => GestureDetector(
                    onTap: () async {
                      bool? isSaved = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditNoteScreen(note: note),
                        ),
                      );

                      if (isSaved == true) {
                        viewModel.onEvent(const NotesEvent.loadNotes());
                      }
                    },
                    child: NoteItem(
                      note: note,
                      onTapDelete: () {
                        viewModel.onEvent(NotesEvent.deleteNote(note));

                        final snackBar = SnackBar(
                          content: const Text('노트가 삭제되었습니다.'),
                          action: SnackBarAction(
                            label: '취소',
                            onPressed: () {
                              viewModel.onEvent(const NotesEvent.restoreNote());
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ))
              .toList(),
        ]),
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
