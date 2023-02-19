import 'dart:convert';

class Tag {
  String tagGuid;
  String title;
  bool isPrivate;
  int owner;

  Tag({required this.tagGuid, required this.title, required this.isPrivate, required this.owner});
  Map<String, dynamic> toJson() {
    return {
      'tag_guid': tagGuid,
      'title': title,
      'is_private': isPrivate ? 1 : 0,
      'owner': owner,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tagGuid: json['tag_guid'],
      title: json['title'],
      isPrivate: json['is_private'] == 1,
      owner: json['owner'],
    );
  }

}