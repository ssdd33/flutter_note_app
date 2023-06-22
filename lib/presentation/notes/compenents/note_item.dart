import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/ui/colors.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function? onTapDelete;
  const NoteItem({
    super.key,
    required this.note,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(note.color),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: darkgrey),
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: darkgrey),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              onTapDelete?.call();
            },
            child: const Icon(
              Icons.delete,
              color: darkgrey,
            ),
          ),
        ),
      ],
    );
  }
}
