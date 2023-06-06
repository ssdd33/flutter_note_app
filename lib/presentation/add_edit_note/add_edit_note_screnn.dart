import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  final List<Color> noteColors = [
    primrose,
    wisteria,
    skyblue,
    roseBud,
    illusion
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        });
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_titleController.text.isEmpty ||
              _contentController.text.isEmpty) {
            const snackbar = SnackBar(content: Text('제목과 내용이 비어있습니다.'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          } else {
            viewModel.onEvent(AddEditNoteEvent.saveNote(
              widget.note == null ? null : widget.note!.id,
              _titleController.text,
              _contentController.text,
            ));
          }
        },
        child: const Icon(Icons.save),
      ),
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          color: Color(viewModel.color),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: noteColors
                    .map(
                      (color) => InkWell(
                        onTap: () {
                          viewModel.onEvent(
                              AddEditNoteEvent.changeColor(color.value));
                        },
                        child: _buildBackgroundColor(
                            color, viewModel.color == color.value),
                      ),
                    )
                    .toList(),
              ),
              TextField(
                controller: _titleController,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: darkgrey),
                decoration: const InputDecoration(
                  hintText: '제목을 입력하세요.',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: darkgrey),
                decoration: const InputDecoration(
                  hintText: '내용을 입력하세요.',
                  border: InputBorder.none,
                ),
              )
            ],
          )),
    );
  }

  Widget _buildBackgroundColor(Color color, bool selected) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: selected
              ? Border.all(
                  color: Colors.black,
                  width: 2.0,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ]),
    );
  }
}
