import 'package:flutter_todo_app/model/ToDoModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoDB {
  static final ToDoDB instance = ToDoDB._init(); //Initializing the database?

  static Database? _DB; //Creating our Database.

  ToDoDB._init();

  Future<Database> get data async {
    if (_DB != null) return _DB!;
    _DB = await _initDB('notes.db');
    return _DB!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath); //Not sure what does this do.

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //This is only executed if the notes.db does not exist in the file system.
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
   CREATE TABLE $TableNotes(
        ${TodoFields.id} $idType,
        ${TodoFields.todoText} $textType,
        ${TodoFields.createdTime} $textType,
        ${TodoFields.isDone} $boolType,
        ${TodoFields.reminder} $textType, //Watch it!
   )
''');
  }

  Future<ToDoModel> create(ToDoModel ToDo) async {
    final db = await instance.data; //Watch out for this too!
    // final columns = '${TodoFields.}'

    // final id = await db
    // .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(TableNotes, ToDo.toJson());
    return ToDo.copy(id: id);
  }

  Future<ToDoModel> readToDo(int id) async {
    final db = await instance.data;

    final maps = await db.query(
      TableNotes,
      columns: TodoFields.values,
      where: '${TodoFields.id}= ?', //Secure from SQL Injections.
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ToDoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<ToDoModel>> readallNotes() async {
    final db = await instance.data;
    final orderBy = '${TodoFields.createdTime} ASC';
    final result = await db.query(TableNotes, orderBy: orderBy);

    return result.map((json) => ToDoModel.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.data;
    return await db.delete(
      TableNotes,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(ToDoModel todomodel) async {
    final db = await instance.data;
    return db.update(
      TableNotes,
      todomodel.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todomodel.id],
    );
  }

  Future close() async {
    final db = await instance.data;
    db.close();
  }
}
