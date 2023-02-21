import 'dart:convert';
import 'package:local_database/models/PrinteableModel.dart';
import 'package:uuid/uuid.dart';

class Tag extends PrintableModel {
  String tagGuid;
  String title;
  bool isPrivate;
  int owner;

  Tag({required this.tagGuid, required this.title, this.isPrivate = true, required this.owner}){

    //If tagGUID is "" then random generate one:
    if(tagGuid==""){
      tagGuid = Uuid().v4();
    }
  }

  @override
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