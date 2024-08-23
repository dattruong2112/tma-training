import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_database/models/book.dart';
import 'package:sqlite_database/models/category.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'library.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        FOREIGN KEY(category) REFERENCES category(categoryName)
      )
    ''');

    await db.execute('''
      CREATE TABLE category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT NOT NULL)
      ''');
  }

  Future<int> insertCategory(String categoryName) async {
    Database db = await database;
    return await db.insert(
      'category',
      {'categoryName': categoryName},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<String>> getCategories() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(maps.length, (i) {
      return maps[i]['categoryName'];
    });
  }

  Future<int> insertBook(Book book) async {
    Database db = await database;
    return await db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getBooks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }

  Future<List<Book>> getAllBooksByCategory(String categoryName) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.rawQuery('''
    SELECT books.*
    FROM books
    INNER JOIN category ON books.category = category.categoryName
    WHERE category.categoryName = ?
  ''', [categoryName]);
    List<Book> books = allRows.map((book) => Book.fromMap(book)).toList();
    return books;
  }
}
