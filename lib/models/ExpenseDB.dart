import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDB {
  static final ExpenseDB _instance = ExpenseDB._internal();

  factory ExpenseDB() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialize();
    }
    return _database;
  }

  ExpenseDB._internal() {
    print("Database was created!");
  }

  initialize() async {
    var folder = await getApplicationDocumentsDirectory();
    var path = join(folder.path, _dbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      String initScript = await rootBundle.loadString(_initScriptPath);
      List<String> scripts = initScript.split(";");
      scripts.forEach((element) {
        if (element.isNotEmpty) {
          db.execute(element.trim());
        }
      });
    });
  }

  Database _database;

  Future<List<ExpenseModel>> _getAllExpenses() async {
    Database db = await database;
    List<Map> queryRes = await db.query("Expenses", orderBy: "dateTime DESC");
    List<ExpenseModel> result = [];
    queryRes.forEach((aElement) => result.add(ExpenseModel.fromMap(aElement)));
    return result;
  }

  Future<String> getTagByID(int aID) async {
    Database db = await database;
    List<Map> queryRes =
        await db.query("Tags", where: "id = ?", whereArgs: [aID]);
    return queryRes.isEmpty ? "" : queryRes.first["name"];
  }

  Future<String> getOwnerByID(int aID) async {
    Database db = await database;
    List<Map> queryRes =
        await db.query("Owners", where: "id = ?", whereArgs: [aID]);
    return queryRes.isEmpty ? "" : queryRes.first["name"];
  }

  Future<void> addExpense(ExpenseModel data) async {
    var dateTime = DateTime.now();
    Database db = await database;
    await db.insert("Expenses", data.toMapWithoutID(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await updateDB();
  }

  List<ExpenseModel> _rows = [];

  int get count => _rows.length;

  ExpenseModel get(int index) {
    return _rows[index];
  }

  Future updateDB() async {
    _rows = await _getAllExpenses();
    populate();
  }

  void removeAt(int index) {
    _rows.removeAt(index);
  }

  final String _dbName = "expenseDB.db";
  final String _initScriptPath = "assets/db/init_script.sql";

  populate() {
    _rows.addAll([
      // @formatter:off
      ExpenseModel(0, 100, "expense0", "", 0, 0, DateTime.now().add(Duration(hours: 1))),
      ExpenseModel(1, 100, "expense1", "", 0, 0, DateTime.now()),
      ExpenseModel(2, 100, "expense2", "", 0, 0, DateTime.now()),
      ExpenseModel(3, 100, "expense3", "", 0, 0, DateTime.now()),
      ExpenseModel(4, 100, "expense4", "", 0, 0, DateTime.now()),
      ExpenseModel(5, 100, "expense5", "", 0, 0, DateTime.now()),
      ExpenseModel(6, 100, "expense6", "", 0, 0, DateTime.now()),
      ExpenseModel(7, 100, "expense7", "", 0, 0, DateTime.now()),
      // @formatter:on
    ]);
  }
// get count => _rows.length;
//
//
// initialize() async {
//   var folder = await getApplicationDocumentsDirectory();
//   var path = join(folder.path, _dbName);
//   return await openDatabase(path, version: 1, onCreate: (db, version) async {
//     String initScript = await rootBundle.loadString(_initScriptPath);
//     List<String> scripts = initScript.split(";");
//     scripts.forEach((element) {
//       if (element.isNotEmpty) {
//         db.execute(element.trim());
//       }
//     });
//   });
// }
//
// Future updateDB() async {
//   _rows = await _getAllExpenses();
// }
//

//
// ExpenseModel getExpenseByIndex(int aIndex) {
//   return _rows.elementAt(aIndex);
// }
//
// // Future<void> addExpense(int aCost, String aName, { String aDesc = "", int aTag, int aOwner} )
//
// List<ExpenseModel> get allExpenses => _rows;
//

//
// Database _database;
// List<ExpenseModel> _rows = [];
//

}
