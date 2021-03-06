import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuple/tuple.dart';

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
    List<Map> queryRes = await db.query("Expenses");
    List<ExpenseModel> result = [];
    queryRes.forEach((aElement) => result.add(ExpenseModel.fromMap(aElement)));
    result.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return result;
  }

  // Future<Tuple2<int, String>> getAllTagsByID(int aExpenseID) async {
  //   Database db = await database;
  //   List<Map> queryRes =
  //     await db.query("Tags", where: "id = ?", whereArgs: [aID]);
  // }

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
    Database db = await database;
    await db.insert("Expenses", data.toMapWithoutID(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await updateDB();
  }

  List<ExpenseModel> _expenses = [];

  int get count => _expenses.length;

  ExpenseModel get(int index) {
    return _expenses[index];
  }

  ExpenseModel getExpenseByID(int aID) {
    return _expenses.firstWhere((element) => element.id == aID, orElse: () {
      return null;
    });
  }

  Future updateDB() async {
    _expenses = await _getAllExpenses();
    // populate();
  }

  double getTotalCost() {
    double res = 0;
    _expenses.forEach((aElement) {
      res += aElement.cost;
    });
    return res;
  }

  Future<void> deleteExpenseByID(int aID) async {
    Database db = await database;
    await db.delete("Expenses", where: "id = ?", whereArgs: [aID]);
    await updateDB();
  }

  Future<void> updateExpenseByID(int aID, ExpenseModel aData) async {
    Database db = await database;
    await db.update("Expenses", aData.toMapWithoutID(),
        where: "id = ?", whereArgs: [aID]);
    await updateDB();
  }

  @deprecated
  void removeAt(int index) {
    _expenses.removeAt(index);
  }

  final String _dbName = "expenseDB.db";
  final String _initScriptPath = "assets/db/init_script.sql";

  populate() {
    _expenses.addAll([
      // @formatter:off
      ExpenseModel(0, 100, "expense0", "", 0, DateTime.now().add(Duration(hours: 1))),
      ExpenseModel(1, 100, "expense1", "", 0, DateTime.now()),
      ExpenseModel(2, 100, "expense2", "", 0, DateTime.now()),
      ExpenseModel(3, 100, "expense3", "", 0, DateTime.now()),
      ExpenseModel(4, 100, "expense4", "", 0, DateTime.now()),
      ExpenseModel(5, 100, "expense5", "", 0, DateTime.now()),
      ExpenseModel(6, 100, "expense6", "", 0, DateTime.now()),
      ExpenseModel(7, 100, "expense7", "", 0, DateTime.now()),
      // @formatter:on
    ]);
  }
}
