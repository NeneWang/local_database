import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:local_database/models/tag_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:local_database/services/utils_helper.dart';
import 'package:local_database/services/database_helper.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    final db = await databaseFactory.openDatabase('test_database.db');
  });

  tearDownAll(() async{
    // Maybe delete the database here
    await deleteDatabase('test_database.db');
  });
  // Run your tests
  group('Utils Helper Tests', () {

    // The tests for now just will be simply printing to check that the basic idea of functions exists

    test('getTagGuidByTitle', () async {
      // Your test code here
      Tag tag = await Future.value(UtilsHelper.getTagByTitle('title'));
      print(tag);
      assert(tag.tagGuid != ""); //Checks that an automated guid is generated.

    });


    test('getTagsIDByTitle', () async {
      // Your test code here
      List<String> titles = ['title', 'anothertitle'];
      List<String> tags = await Future.value(UtilsHelper.getTagsIDByTitle(titles));
      print(tags);


      //  Prints to check if they are correctly printed.
      final result = await DatabaseHelper.getAllTags();
      print(result);

    });


  });
}

