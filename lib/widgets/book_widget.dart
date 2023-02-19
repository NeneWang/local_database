import 'package:flutter/material.dart';
import 'package:local_database/models/note_model.dart';
import 'package:local_database/models/book_staging_model.dart';

class BookWidget extends StatefulWidget {
  final BookStaging bookStaging;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final void Function(BookStaging) onComplete;
  final VoidCallback onEdit;

  const BookWidget({
    Key? key,
    required this.bookStaging,
    required this.onTap,
    required this.onLongPress,
    required this.onComplete,
    required this.onEdit,
  }) : super(key: key);

  @override
  _BookWidgetState createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {

  @override
  Widget build(BuildContext context) {
    int _status = widget.bookStaging.status??0;
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
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
                        widget.bookStaging.bookTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _status = _status == 1 ? 0 : 1;
                        });
                        widget.onComplete(widget.bookStaging);
                      },
                      icon: Icon(
                        _status == 1
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: widget.onEdit,
                    //   icon: Icon(Icons.edit),
                    // ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(
                  widget.bookStaging.userNotes ?? "",
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
