import 'dart:convert';

class Tag {
  String tagGuid;
  String title;
  bool isPrivate;
  int owner;

  Tag({required this.tagGuid, required this.title, required this.isPrivate, required this.owner});

  Map<String, dynamic> toJson() {
    return {
      'tagGuid': tagGuid,
      'title': title,
      'isPrivate': isPrivate ? 1 : 0,
      'owner': owner,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tagGuid: json['tagGuid'],
      title: json['title'],
      isPrivate: json['isPrivate'] == 1,
      owner: json['owner'],
    );
  }
}