import 'package:loginflutter/model/member.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbMember {
  static final DbMember _instance = DbMember._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableMember';
  final String id = 'id';
  final String name = 'name';
  final String address = 'address';
  final String gender = 'gender';
  final String date = 'date';
  final String username = 'username';
  final String password = 'password';

  DbMember._internal();
  factory DbMember() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'member.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($id INTEGER PRIMARY KEY, "
        "$name TEXT,"
        "$address TEXT,"
        //
            "$gender TEXT,"
        "$date TEXT,"
        "$username TEXT,"
        "$password TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveMember(Member member) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, member.toMap());
  }

  //read database
  Future<List?> getAllMember() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      id, name, address,
      gender,
      date, username, password
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateMember(Member member) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, member.toMap(),
        where: '$id = ?', whereArgs: [member.id]);
  }

  //hapus database
  Future<int?> deleteMember(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$id = ?', whereArgs: [id]);
  }
}
