import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class DeleteNoteUC {
  final NoteRepository noteRepository;

  DeleteNoteUC(this.noteRepository);

  Future<void> call(Note note) async {
    await noteRepository.deleteNote(note);
  }
}
