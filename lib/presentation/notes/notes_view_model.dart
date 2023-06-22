import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/use_cases.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }
  NotesState _state = NotesState();
  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  void onEvent(NotesEvent event) {
    event.when(
      changeOrder: (NoteOrder noteOrder) {
        _state = _state.copyWith(noteOrder: noteOrder);
        _loadNotes();
      },
      loadNotes: _loadNotes,
      deleteNote: _deleteNotes,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotesUseCase(state.noteOrder);

    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNotes(Note note) async {
    await useCases.deleteNoteUseCase(note);
    await _loadNotes();

    _recentlyDeleteNote = note;
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      useCases.addNoteUseCase(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
      _loadNotes();
    }
  }
}
