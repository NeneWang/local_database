import 'package:local_database/models/note_model.dart';
import 'package:local_database/services/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:local_database/models/book_staging_model.dart';
import 'package:local_database/models/tag_model.dart';

class DatabaseHelper {
  static const int _version = 4;
  static const String _dbName = "Notes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"
          );
          await db.execute(
              "CREATE TABLE book_staging(bookstaging_id INTEGER PRIMARY KEY, book_id INTEGER, book_title TEXT NOT NULL, user_notes TEXT, user_guid TEXT, status INTEGER, priority INTEGER, tags TEXT, image_src TEXT);"
          );
          await db.execute(
              "CREATE TABLE tags(tag_guid TEXT PRIMARY KEY, title TEXT NOT NULL, is_private INTEGER NOT NULL, owner INTEGER NOT NULL);"
          );
        },
      version: _version
    );
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }


  //  Book Staging

  static Future<int> addBookStaging(BookStaging bookStaging) async {
    final db = await _getDB();
    return await db.insert("book_staging", bookStaging.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateBookStaging(BookStaging bookStaging) async {
    final db = await _getDB();
    return await db.update("book_staging", bookStaging.toJson(),
        where: 'bookstaging_id = ?',
        whereArgs: [bookStaging.bookstagingId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBookStaging(BookStaging bookStaging) async {
    final db = await _getDB();
    return await db.delete(
      "book_staging",
      where: 'bookstaging_id = ?',
      whereArgs: [bookStaging.bookstagingId],
    );
  }

  static Future<List<BookStaging>?> getAllBookStaging() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("book_staging");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => BookStaging.fromJson(maps[index]));
  }


  //Tags
  static Future<int> addTag(Tag tag) async {
    final db = await _getDB();
    return await db.insert("tags", tag.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTag(Tag tag) async {
    final db = await _getDB();
    return await db.update("tags", tag.toJson(),
        where: 'tag_guid = ?',
        whereArgs: [tag.tagGuid],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTag(Tag tag) async {
    final db = await _getDB();
    return await db.delete(
      "tags",
      where: 'tag_guid = ?',
      whereArgs: [tag.tagGuid],
    );
  }

  static Future<List<Tag>?> getAllTags() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("tags");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Tag.fromJson(maps[index]));
  }


  static Future<Tag> getTagByTitle(String title,
      {bool createIfDoesntExists = false}) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("tags",
    where: "title = ?",
    whereArgs: [title],
    limit: 1);

    if (maps.isEmpty) {
      //Create if doens't exist
      Tag tagToCreate = Tag(tagGuid: "", title: title, owner: Constants.user_id);
      addTag(tagToCreate);
      return tagToCreate;
    }

    return Tag.fromJson(maps.first);
  }


  static Future<void> toggleComplete(BookStaging bookStaging) async {
    bookStaging.status = bookStaging.status == 1 ? 0 : 1;
    await updateBookStaging(bookStaging);
  }
}
