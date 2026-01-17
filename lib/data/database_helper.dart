import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bmi_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Web support check
    if (kIsWeb) {
      var factory = databaseFactoryFfiWeb;
      return await factory.openDatabase(filePath,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: _createDB,
          ));
    }
    
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE history ADD COLUMN weight REAL');
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE history ( 
  id $idType, 
  date $textType,
  bmi $realType,
  weight $realType,
  status $textType
  )
''');
  }

  Future<int> create(Map<String, dynamic> json) async {
    final db = await instance.database;
    return await db.insert('history', json);
  }

  Future<List<Map<String, dynamic>>> readAllHistory() async {
    final db = await instance.database;
    const orderBy = 'date DESC';
    return await db.query('history', orderBy: orderBy);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<int> deleteAll() async {
    final db = await instance.database;
    return await db.delete('history');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
