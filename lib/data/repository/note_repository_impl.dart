import 'package:flutter_note_app/data/source/note_db_helper.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class NoteRepositoryImple implements NoteRepository {
  final NoteDbHelper noteDbHelper;
  NoteRepositoryImple(
    this.noteDbHelper,
  );
  @override
  Future<void> deleteNote(Note note) async {
    await noteDbHelper.deleteNote(note);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await noteDbHelper.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await noteDbHelper.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await noteDbHelper.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await noteDbHelper.updateNote(note);
  }
}
