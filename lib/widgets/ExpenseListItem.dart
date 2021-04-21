import 'package:expense_manager/dialogs/EditExpenseDialog.dart';
import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListItem extends StatelessWidget {
  final Function() notifyParent;

  ExpenseListItem({this.index, this.data, @required this.notifyParent});

  final int index;
  final ExpenseModel data;
  final ExpenseDB _db = ExpenseDB();
  final TextStyle _nameStyle = TextStyle(fontSize: 20);
  final TextStyle _dateStyle = TextStyle(
    fontSize: 14,
  );
  final TextStyle _costStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  @override
  Widget build(BuildContext aContext) {
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: _nameStyle,
              ),
              Text(
                DateFormat("dd-MM-yyyy HH:mm").format(data.dateTime),
                style: _dateStyle,
              )
            ],
          ),
        ),
        // if (data.owner != 0 || data.tag != 0) Expanded(child: Column()),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.cost.toString(),
                style: _costStyle,
              )
            ],
          ),
        ),
      ],
    );
    return GestureDetector(
      onLongPress: () async {
        await showDialog(
          context: aContext,
          builder: (BuildContext aContext) {
            return SimpleDialog(
              title: const Text("Options"),
              children: [
                SimpleDialogOption(
                  child: const Text("Edit"),
                  onPressed: () {
                    Navigator.push(
                      aContext,
                      MaterialPageRoute(builder: (context) {
                        return EditExpenseDialog(
                          aExpenseID: data.id,
                        );
                      }),
                    ).then((value) => Navigator.pop(aContext)).then((value) => notifyParent());
                  },
                ),
                SimpleDialogOption(
                  child: const Text("Delete"),
                  onPressed: () {
                    ExpenseDB()
                        .deleteExpenseByID(data.id)
                        .then((value) => Navigator.pop(aContext)).then((value) => notifyParent());
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card(
        child:
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 5), child: content),
      ),
    );
  }
}
