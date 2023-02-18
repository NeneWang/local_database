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
  String? imageSrc;

  BookStaging({this.bookstagingId, required this.bookId, required this.bookTitle, this.userNotes, this.userGuid, this.status, this.priority, this.tags, this.imageSrc});

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
      'imageSrc': imageSrc,
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
      imageSrc: json['imageSrc'],
    );
  }
}