import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/job.dart'; // Make sure you have a compatible Job model

class DatabaseHelper {
  static final _databaseName = "bookmarks.db";
  static final _databaseVersion = 1;
  static final table = 'bookmarked_jobs';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY,
        title TEXT,
        location TEXT,
        salary TEXT,
        phone TEXT,
        companyName TEXT,
        content TEXT,
        experience TEXT,
        qualification TEXT,
        jobRole TEXT,
        jobHours TEXT,
        openingsCount INTEGER,
        otherDetails TEXT,
        buttonText TEXT,
        customLink TEXT
      )
    ''');
  }

  Future<int> insertBookmark(Job job) async {
    Database db = await database;
    return await db.insert(
      table,
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeBookmark(int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Job>> getBookmarkedJobs() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => Job.fromMap(map)).toList();
  }

  Future<bool> isBookmarked(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }
}
