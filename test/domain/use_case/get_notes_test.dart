import 'package:flutter_note_app/data/repository/note_repository_impl.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/get_notes.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notes_test.mocks.dart';

@GenerateMocks([NoteRepositoryImple])
void main() {
  test('정렬 기능이 잘 동작해야 한다', () async {
    final repository = MockNoteRepositoryImple();
    final getNotesUseCase = GetNotesUC(repository);

    //기준 동작 정의
    when(repository.getNotes()).thenAnswer((_) async => [
          Note(
            title: 'title',
            content: 'content',
            timestamp: 0,
            color: 1,
          ),
          Note(
            title: 'title2',
            content: 'content2',
            timestamp: 2,
            color: 2,
          )
        ]);

    List<Note> result =
        await getNotesUseCase(const NoteOrder.date(OrderType.ascending()));

    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 0);
    verify(repository.getNotes());

    result =
        await getNotesUseCase(const NoteOrder.date(OrderType.descending()));
//타입검사
    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 2);
    //함수가 실행됐는지 확인
    verify(repository.getNotes());

//더이상 로직이 실행되지 않았는지 확인
    verifyNoMoreInteractions(repository);
  });
}
