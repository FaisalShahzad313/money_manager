import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqliteService
{
  Database? _db;
  static const _dbName = "moneyDB";
  //private constructor to avoid read-only status of database
SqliteService._privateConstructor();
static final SqliteService instance  = SqliteService._privateConstructor();
Future<Database> get db async
 {
  _db ??= await initDB();
  return _db!;
 }

 // this function is used for initializing database
  initDB() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path,onCreate: _onCreate,version: 3);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
  await db.execute(
    '''
    Create Table if not exists categories(
    id Integer primary key autoincrement,
    name Text ,
    type Text
    );
    '''
  );

  await db.execute(
      '''
    Create Table if not exists transactions(
    id Integer primary key autoincrement,
    category Text ,
    type Text,
    amount double , 
    note Text ,
    description Text ,
    transactionDate Date ,
    imagePath Text
    );
    '''
  );
  }
  Future<int> insert(String query) async
  {
    Database database = await db;
    int id = await database.rawInsert(query);
    return id;

  }
  Future<int> update(String query) async
  {
    Database database = await db;
    int id = await database.rawUpdate(query);
    return id;
  }
  Future<int> delete(String query) async
  {
    Database database = await db;
    int id = await database.rawDelete(query);
    return id;
  }
  Future<List<Map<String,dynamic>>> getAllRows(String query) async
  {
    Database database = await db;
    var result = await database.rawQuery(query);
    return result;
  }
}