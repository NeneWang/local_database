import 'dart:convert';

class BookStaging {
  int? bookstagingId;
  int bookId;
  String bookTitle;
  String? userNotes;
  String? userGuid;
  int? status;
  int? priority;
  List<String>? tags;

  BookStaging({this.bookstagingId, required this.bookId, required this.bookTitle, this.userNotes, this.userGuid, this.status, this.priority, this.tags});

  Map<String, dynamic> toJson() {
    return {
      'bookstagingId': bookstagingId,
      'bookId': bookId,
      'bookTitle': bookTitle,
      'userNotes': userNotes,
      'userGuid': userGuid,
      'status': status,
      'priority': priority,
      'tags': tags != null ? json.encode(tags) : null,
    };
  }

  factory BookStaging.fromJson(Map<String, dynamic> json) {
    return BookStaging(
      bookstagingId: json['bookstagingId'],
      bookId: json['bookId'],
      bookTitle: json['bookTitle'],
      userNotes: json['userNotes'],
      userGuid: json['userGuid'],
      status: json['status'],
      priority: json['priority'],
      tags: json['tags'] != null ? List<String>.from(jsonDecode(json['tags'])) : null,
    );
  }
}