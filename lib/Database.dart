import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future setDatabase(String tableName) async {
// Get a location using getDatabasesPath
  try {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'county_test.db');

    Database database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, detail TEXT, amount INTEGER, timeStamp DATETIME DEFAULT CURRENT_TIMESTAMP)');
      await db.execute(
          'CREATE TABLE TotalAmount (id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER)');
    });

    print(" $tableName and TotalAmount are successfully created");
    return database;
  } catch (e) {
    print("error: " + e.message);
  }
}

void insertTotable(
    String tableName, String title, String detail, double amount) async {
  // Insert some records in a transaction
  Database database;
  await setDatabase(tableName).then((db) {
    database = db;
  });
  await database.transaction((txn) async {
    int id2 = await txn.rawInsert(
        'INSERT INTO $tableName(title, detail, amount) VALUES(?, ?, ?)',
        [title, detail, amount]);
  });
}

void insertTotalToTable(double amount) async {
  try {
    Database database;
    await setDatabase("naveen").then((db) {
      database = db;
    });
    await database.transaction((txn) async {
      int id2 = await txn
          .rawInsert('INSERT INTO TotalAmount(amount) VALUES(?)', [amount]);
    });
  } catch (e) {
    print("Error: " + e.message);
  }
}

Future viewTable(String tableName) async {
  Database database;
  await setDatabase(tableName).then((db) {
    database = db;
  });
  List<Map> list = await database.rawQuery('SELECT * FROM $tableName');
  return list;
}

Future viewTotalTable() async {
  Database database;
  await setDatabase("naveen").then((db) {
    database = db;
  });
  List<Map> list1 = await database.rawQuery(
      'SELECT amount FROM TotalAmount WHERE id = (SELECT MAX(id) FROM TotalAmount)');
  List<Map> list2 = await database.rawQuery(
      "SELECT SUM(amount) AS 'METRO' FROM naveen WHERE title = ?",
      ["METRO RECHARGE"]);
  List<String> result = new List<String>();
  if (list1.isEmpty) {
    result.add("0.0");
  } else {
    result.add(list1[0].values.toList()[0].toString());
  }
  if (list2[0].values.toList()[0].toString() == "null") {
    result.add("0.0");
  } else {
    result.add(list2[0].values.toList()[0].toString());
  }
  return result;
}

Future removeLastEntryFromTable(String tableName) async {
  Database database;
  await setDatabase("naveen").then((db) {
    database = db;
  });
  List<Map> list = await database.rawQuery(
      "DELETE FROM $tableName WHERE id = (SELECT MAX(id) FROM $tableName)");
  return list;
}

Future<bool> removeEntryFromTable(String tableName, int id) async {
  Database database;
  await setDatabase(tableName).then((db) {
    database = db;
  });
  int row = await database.delete(tableName, where:"id == $id");
  if(row > 0) {
    print("$row deleted");
    return true;
  }
  else {
    print("$row deleted");
    return false;
  }
}

Future<bool> renameEntryFromTable(String tableName, int id, String newTitle) async {
  Database database;
  await setDatabase(tableName).then((db) {
    database = db;
  });
  Map<String, String> entry = Map();
  entry["title"] = newTitle;
  int row = await database.update(tableName, entry, where:"id == $id");
  if(row > 0) {
    print("$row updated");
    return true;
  }
  else {
    print("$row not updated");
    return false;
  }
}

Future viewSumTable(String tableName) async {
  Database database;
  await setDatabase(tableName).then((db) {
    database = db;
  });
  List<Map> list =
      await database.rawQuery('SELECT Sum(amount) FROM $tableName');
  double sum = double.parse(
      list[0].values.toString().replaceAll("(", "").replaceAll(")", ""));
  return sum;
}
