import 'package:flutter_test/flutter_test.dart';

import 'package:local_database/services/database_helper.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:local_database/models/note_model.dart';
import 'package:local_database/models/book_staging_model.dart';
import 'package:local_database/models/tag_model.dart';


void main() {
  late Database database;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
  });

  tearDownAll(() {
    // Maybe delete the database here
  });
  group('DatabaseHelper tests', () {
    // late DatabaseHelper db;


    test('Add and retrieve note', () async {
      // Create a test note
      final note = Note(
        id: 1,
        title: 'Test Note',
        description: 'This is a test note',
      );

      // Add the note to the database
      final result = await DatabaseHelper.addNote(note);

      // Verify that the note was added successfully
      expect(result, 1);

      // Retrieve all notes from the database
      final notes = await DatabaseHelper.getAllNotes();

      // Verify that the notes list contains the added note
      expect(notes?.length, 1);
      expect(notes?[0].id, note.id);
      expect(notes?[0].title, note.title);
      expect(notes?[0].description, note.description);
    });

    test('Can add and get a BookStaging object', () async {
      final bookStaging = BookStaging(
          bookstagingId: 1,
          bookId: 123,
          bookTitle: 'Flutter in Action',
          userNotes: 'Great book',
          userGuid: 'user-123',
          status: 0,
          priority: 1,
          tags: ['flutter', 'mobile'],
          imageSrc: 'https://example.com/image.png');

      await DatabaseHelper.addBookStaging(bookStaging);

      final result = await DatabaseHelper.getAllBookStaging();

      expect(result!.length, 1);
      expect(result.first.bookstagingId, bookStaging.bookstagingId);
      expect(result.first.bookId, bookStaging.bookId);
      expect(result.first.bookTitle, bookStaging.bookTitle);
      expect(result.first.userNotes, bookStaging.userNotes);
      expect(result.first.userGuid, bookStaging.userGuid);
      expect(result.first.status, bookStaging.status);
      expect(result.first.priority, bookStaging.priority);
      expect(result.first.tags, bookStaging.tags);
      expect(result.first.imageSrc, bookStaging.imageSrc);
    });

    test('Can add and get a Tag object', () async {
      final tag = Tag(
          tagGuid: 'tag-123',
          title: 'Flutter',
          isPrivate: false,
          owner: 1);

      await DatabaseHelper.addTag(tag);

      final result = await DatabaseHelper.getAllTags();

      expect(result!.length, 1);
      expect(result.first.tagGuid, tag.tagGuid);
      expect(result.first.title, tag.title);
      expect(result.first.isPrivate, tag.isPrivate);
      expect(result.first.owner, tag.owner);
    });
  });

}
