import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:local_database/services/utils_helper.dart';
import 'package:local_database/models/tag_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite_common_ffi
  sqfliteFfiInit();
  dynamic databaseFactory = databaseFactoryFfi;

  // Run your tests
  group('Utils Helper Tests', () {
    test('getTagGuidByTitle', () async {
      // Your test code here
      Tag tag = await Future.value(UtilsHelper.getTagByTitle('title'));
      print(tag.title);
    });
  });
}

