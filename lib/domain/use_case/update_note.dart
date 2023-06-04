import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class UpdateNoteUC {
  final NoteRepository noteRepository;

  UpdateNoteUC(this.noteRepository);

  Future<void> call(Note note) async {
    await noteRepository.updateNote(note);
  }
}
