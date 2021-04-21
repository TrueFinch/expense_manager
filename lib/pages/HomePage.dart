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

  void notify() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int _expensesCount = _db.count;
    double _expensesSum = _db.getTotalCost();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total expenses: " + _expensesCount.toString()),
                    Text("Total cost: " + _expensesSum.toString()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (aContext, aIndex) {
                  var element = _db.get(aIndex);
                  return ExpenseListItem(index: aIndex, data: element, notifyParent: notify,);
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemCount: _db.count,
              ),
            ),
          ],
        ),
      ),
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
