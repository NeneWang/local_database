import 'package:flutter/material.dart';
import 'package:local_database/models/note_model.dart';
import 'package:local_database/models/book_staging_model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final BookStaging bookStaging;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final void Function(BookStaging) onComplete;
  final VoidCallback onEdit;

  const NoteWidget({
    Key? key,
    required this.bookStaging,
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.onComplete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){onComplete(bookStaging);},
                      icon: Icon(
                        true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(
                  note.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
