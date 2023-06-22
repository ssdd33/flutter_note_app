import 'package:flutter_note_app/domain/use_case/add_note.dart';
import 'package:flutter_note_app/domain/use_case/delete_note.dart';
import 'package:flutter_note_app/domain/use_case/get_note.dart';
import 'package:flutter_note_app/domain/use_case/get_notes.dart';
import 'package:flutter_note_app/domain/use_case/update_note.dart';

class UseCases {
  final AddNoteUC addNoteUseCase;
  final DeleteNoteUC deleteNoteUseCase;
  final GetNoteUC getNoteUseCase;
  final GetNotesUC getNotesUseCase;
  final UpdateNoteUC updateNoteUseCase;

  UseCases({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.getNotesUseCase,
    required this.updateNoteUseCase,
  });
}
