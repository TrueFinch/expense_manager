import 'package:expense_manager/dialogs/EditExpenseDialog.dart';
import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/widgets/ExpenseListItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ExpenseDB _db = ExpenseDB();

  _HomePageState() {
    _db.updateDB().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemBuilder: (aContext, aIndex) {
            var element = _db.get(aIndex);
            return ExpenseListItem(index: aIndex, data: element);
          },
          separatorBuilder: (context, index) => Divider(
                thickness: 1,
              ),
          itemCount: _db.count),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditExpenseDialog();
          })).then((value) => setState(() {}));
        },
      ),
    );
  }
}
