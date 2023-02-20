
import 'package:local_database/models/book_staging_model.dart';
import 'package:local_database/models/tag_model.dart';
import 'package:local_database/screens/book_screen.dart';
import 'package:local_database/services/constants.dart';
import 'package:local_database/services/database_helper.dart';

class UtilsHelper{


  static Future<List<String>> getTagsIDByTitle(List<String> titles) async{
    List<String> tagsId = [];
    for(String title in titles){
      Tag tag = await DatabaseHelper.getTagByTitle(title);
      tagsId.add(tag.title);

    }
    return tagsId;
  }

  static Future<Tag> getTagGuidByTitle(String title) async{
    //  Gets the tag by title, if its null, then create one with the current user id.
    
     Tag tagExisting = await DatabaseHelper.getTagByTitle(title, createIfDoesntExists: true);
     return Future.value(tagExisting);
  }

  /**
   * Handles the logic of creating tags then appending those tags to the books
   */
  static void HandleBookCreationDetails({String book_title = "", List<String> tags = const [], String user_notes = "" }) async {

    //   'book_title': bookTitle,
    //   'user_notes': userNotes,
    List<String> tagIds = await getTagsIDByTitle(tags);
    BookStaging newBook = BookStaging(bookTitle: book_title, userNotes: user_notes, tags: tagIds);
    DatabaseHelper.addBookStaging(newBook);


  }
}


