import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDB {
  ExpenseDB() {
    populate();
  }

  populate() {
    _rows.addAll([
      // @formatter:off
      ExpenseModel(0, 100, "", "expense0", "", "", DateTime.now()),
      ExpenseModel(1, 100, "", "expense1", "", "", DateTime.now()),
      ExpenseModel(2, 100, "", "expense2", "", "", DateTime.now()),
      ExpenseModel(3, 100, "", "expense3", "", "", DateTime.now()),
      ExpenseModel(4, 100, "", "expense4", "", "", DateTime.now()),
      ExpenseModel(5, 100, "", "expense5", "", "", DateTime.now()),
      ExpenseModel(6, 100, "", "expense6", "", "", DateTime.now()),
      ExpenseModel(7, 100, "", "expense7", "", "", DateTime.now()),
      // @formatter:on
    ]);
  }

  initialize() async {
    var folder = await getApplicationDocumentsDirectory();
    var path = join(folder.path, _dbName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      String initScript = await rootBundle.loadString(_initScriptPath);
      List<String> scripts = initScript.split(";");
      scripts.forEach((element) {
        if (element.isNotEmpty) {
          db.execute(element.trim());
        }
      });
    });
  }

  Future<void> updateDB() async {
    _rows = await _getAllExpenses();
  }

  // Future<void> addExpense(int aCost, String aName, { String aDesc = "", int aTag, int aOwner} )

  List<ExpenseModel> get allExpenses => _rows;

  Future<List<ExpenseModel>> _getAllExpenses() async {
    Database db = await _database;
    List<Map> queryRes = await db.query("Expenses", orderBy: "dateTime DESC");
    List<ExpenseModel> result = [];
    queryRes.forEach((element) {
      result.add(ExpenseModel.fromMap(element));
    });
    return result;
  }

  Database _database;
  List<ExpenseModel> _rows = [];

  final String _dbName = "expenseDB.db";
  final String _initScriptPath = "assets\\db\\init_script.sql";
}
