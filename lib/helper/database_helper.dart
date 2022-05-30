import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/category.dart';
import '../model/history.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  factory DatabaseHelper() => instance;
  DatabaseHelper.internal();

  static Database? _database;

  final _databaseName = 'sbrowser.db';

  final _historyTable = 'history';
  final _categoryTable = 'category';
  final _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_historyTable (
        id TEXT PRIMARY KEY,
        url TEXT,
        domain TEXT,
        createdAt TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_categoryTable (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon TEXT,
        isFromAssets TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<History> insertHistory(History history) async {
    final db = await database;
    await db.insert(_historyTable, history.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    Get.log('Inserted history: ${history.url}');
    return history;
  }

  Future<Category> insertCategory(Category category) async {
    final db = await database;
    await db.insert(_categoryTable, category.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    Get.log('Inserted category: ${category.name}');
    return category;
  }

  Future<List<History>> getAllHistory() async {
    final db = await database;
    final history = await db.query(_historyTable);
    return history.map((e) => History.fromJson(e)).toList();
  }

  Future<List<Category>> getAllCategory() async {
    final db = await database;
    final category = await db.query(_categoryTable);
    return category.map((e) => Category.fromJson(e)).toList();
  }
}
