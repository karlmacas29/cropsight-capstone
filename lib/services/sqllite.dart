import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//create database
Future<Database> initializeDB() async {
  var directory = await getApplicationDocumentsDirectory();
  var path = join(directory.path, 'pest_database.db');

  try {
    // Check if the database file already exists
    bool dbExists = await databaseExists(path);

    if (!dbExists) {
      // If the database does not exist, create it and set up the tables
      var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE items(idPest INTEGER PRIMARY KEY AUTOINCREMENT, namePest VARCHAR(255), pestDesc VARCHAR(255)))",
          );
        },
      );
      return database;
    } else {
      // If the database exists, open it without creating
      var database = await openDatabase(path);
      return database;
    }
  } catch (e) {
    // Handle any errors that might occur during database initialization
    throw Exception('Error initializing the database: $e');
  }
}

//Create
Future<int> insertItem(Database db, String name, String description) async {
  var result = await db.insert(
    'items',
    {'name': name, 'description': description},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return result;
}

//Read
Future<List<Map<String, dynamic>>> retrieveItems(Database db) async {
  var result = await db.query('items');
  return result;
}

//Update
Future<int> updateItem(
    Database db, int id, String name, String description) async {
  var result = await db.update(
    'items',
    {'name': name, 'description': description},
    where: 'id = ?',
    whereArgs: [id],
  );
  return result;
}

//Delete
Future<int> deleteItem(Database db, int id) async {
  var result = await db.delete(
    'items',
    where: 'id = ?',
    whereArgs: [id],
  );
  return result;
}
