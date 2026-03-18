import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE history ADD COLUMN weight REAL DEFAULT 0.0');
    }
    if (oldVersion < 3) {
      await db.execute("ALTER TABLE history ADD COLUMN userId TEXT DEFAULT ''");
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE history ( 
  id $idType, 
  userId $textType,
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

  Future<List<Map<String, dynamic>>> readHistoryForUser(String userId) async {
    final db = await instance.database;
    const orderBy = 'date DESC';
    return await db.query('history', where: 'userId = ?', whereArgs: [userId], orderBy: orderBy);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<int> deleteAllForUser(String userId) async {
    final db = await instance.database;
    return await db.delete('history', where: 'userId = ?', whereArgs: [userId]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
