import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditExpenseDialogState extends State<EditExpenseDialog> {
  EditExpenseDialog({aExpenseID = -1}) {
    if (aExpenseID == -1) {
      _data = {
        "id": -1,
        "dateTime": DateTime.now(),
        "desc": "",
        "name": "",
        "tag": 0,
        "owner": 0,
        "cost": 0,
      };
    } else {
      var oldModel = ExpenseDB().getExpenseByID(aExpenseID);
      _data = oldModel.toMapFull();
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ExpenseDB().getExpenseByID(widget._expenseID);
    return Scaffold(
      appBar: AppBar(title: Text("Edit expense")),
      body: Form(
          key: _formState,
          child: Column(
            children: [
              Text("Name", style: _nameStyle),
              TextFormField(
                style: _nameEditStyle,
                autovalidateMode: AutovalidateMode.always,
                validator: (aValue) {
                  if (aValue.length < 3) {
                    return "Too short description!";
                  }
                  return null;
                },
                onSaved: (aValue) {
                  _data["name"] = aValue;
                },
              ),
              Text("Description", style: _descStyle),
              TextFormField(
                style: _descEditStyle,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (aValue) {
                  _data["desc"] = aValue;
                },
              ),
              Text("Cost", style: _costStyle),
              TextFormField(
                style: _costEditStyle,
                onSaved: (aValue) {
                  _data["cost"] = aValue;
                },
              )
            ],
          )),
    );
  }

  // Widget _buildDropDown(Icon aIcon, List<String> aItems) {
  //   return DropdownButton<String>(
  //       items: aItems.map((String aElement) => DropdownMenuItem(child: Text()))
  //   );
  // }

  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  Map<String, dynamic> _data;

  final TextStyle _nameStyle = TextStyle(fontSize: 48);
  final TextStyle _nameEditStyle = TextStyle(fontSize: 36);
  final TextStyle _descStyle = TextStyle(fontSize: 48);
  final TextStyle _descEditStyle = TextStyle(fontSize: 36);
  final TextStyle _costStyle = TextStyle(fontSize: 48);
  final TextStyle _costEditStyle = TextStyle(fontSize: 36);
}

class EditExpenseDialog extends StatefulWidget {
  EditExpenseDialog({aExpenseID = -1}) {
    _expenseID = aExpenseID;
  }

  @override
  State<StatefulWidget> createState() {
    return EditExpenseDialogState();
  }

  int _expenseID = -1;
}
