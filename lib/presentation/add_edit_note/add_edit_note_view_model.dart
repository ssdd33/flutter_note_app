import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository noteRepository;
  int _color = Colors.orange.value;
  AddEditNoteViewModel(this.noteRepository);

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (id == null) {
      await noteRepository.insertNote(Note(
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    } else {
      await noteRepository.updateNote(Note(
        id: id,
        title: title,
        content: content,
        color: _color,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    }
  }
}
