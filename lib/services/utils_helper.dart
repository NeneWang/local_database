
import 'package:local_database/models/tag_model.dart';
import 'package:local_database/services/constants.dart';
import 'package:local_database/services/database_helper.dart';

class UtilsHelper{
  static Future<Tag> getTagGuidByTitle(String title) async{
    //  Gets the tag by title, if its null, then create one with the current user id.
    
     Tag tagExisting = await DatabaseHelper.getTagByTitle(title, createIfDoesntExists: true);
     return Future.value(tagExisting);
  }
}


