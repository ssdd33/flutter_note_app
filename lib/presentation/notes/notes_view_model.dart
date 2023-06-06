import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final NoteRepository noteRepository;

  NotesViewModel(this.noteRepository) {
    _loadNotes();
  }
  NotesState _state = NotesState();
  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  void onEvent(NotesEvent event) {
    event.when(
        loadNotes: _loadNotes,
        deleteNote: _deleteNotes,
        restoreNote: _restoreNote);
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await noteRepository.getNotes();
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNotes(Note note) async {
    await noteRepository.deleteNote(note);
    await _loadNotes();

    _recentlyDeleteNote = note;
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      noteRepository.insertNote(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
      _loadNotes();
    }
  }
}
