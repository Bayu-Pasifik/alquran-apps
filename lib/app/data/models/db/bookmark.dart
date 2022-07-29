import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabseManager {
  DatabseManager._private();
  static final DatabseManager instance = DatabseManager._private();

  Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return await initDb();
    }
    return _db!;
  }

  Future initDb() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'bookmark.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (databse, version) async {
      return await databse.execute('''
            CREATE TABLE bookmark (id INTEGER PRIMARY KEY AUTOINCREMENT, surah TEXT NOT NULL, ayat TEXT NOT NULL, via TEXT NOT NULL, index_ayat TEXT NOT NULL, last_read INTEGER DEFAULT 0)
''');
    });
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
