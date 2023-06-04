import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class AddNoteUC {
  final NoteRepository noteRepository;

  AddNoteUC(this.noteRepository);

  Future<void> call(Note note) async {
    await noteRepository.insertNote(note);
  }
}
