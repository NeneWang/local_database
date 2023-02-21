import 'dart:convert';

import 'package:local_database/models/PrinteableModel.dart';

class BookStaging extends PrintableModel {
  int? bookstagingId;
  int? bookId;
  String bookTitle;
  String? userNotes;
  String? userGuid;
  int? status;
  int? priority;
  List<String>? tags;
  String? imageSrc;

  BookStaging(
      {this.bookstagingId, this.bookId, required this.bookTitle, this.userNotes, this.userGuid, this.status, this.priority, this.tags, this.imageSrc});

  @override
  Map<String, dynamic> toJson() {
    return {
      'bookstaging_id': bookstagingId,
      'book_id': bookId,
      'book_title': bookTitle,
      'user_notes': userNotes,
      'user_guid': userGuid,
      'status': status,
      'priority': priority,
      'tags': tags != null ? json.encode(tags) : null,
      'image_src': imageSrc,
    };
  }

  factory BookStaging.fromJson(Map<String, dynamic> json) {
    return BookStaging(
      bookstagingId: json['bookstaging_id'],
      bookId: json['book_id'],
      bookTitle: json['book_title'],
      userNotes: json['user_notes'],
      userGuid: json['user_guid'],
      status: json['status'],
      priority: json['priority'],
      tags: json['tags'] != null
          ? List<String>.from(jsonDecode(json['tags']))
          : null,
      imageSrc: json['image_src'],
    );
  }
}