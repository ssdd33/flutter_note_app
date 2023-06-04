import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class GetNotesUC {
  final NoteRepository noteRepository;

  GetNotesUC(this.noteRepository);

  Future<List<Note>> call() async {
    List<Note> notes = await noteRepository.getNotes();

    return notes;
  }
}
