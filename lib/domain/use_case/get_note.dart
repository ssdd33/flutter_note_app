import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class GetNoteUC {
  final NoteRepository noteRepository;

  GetNoteUC(this.noteRepository);

  Future<Note?> call(int id) async {
    return await noteRepository.getNoteById(id);
  }
}
