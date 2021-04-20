import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tuple/tuple.dart';

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
  Widget build(BuildContext aContext) {
    var currentDateTime =
    _data["id"] == -1 ? DateTime.now() : DateTime.parse(_data["dateTime"]);
    return Scaffold(
      appBar: AppBar(title: Text("Edit expense")),
      body: Form(
          key: _formState,
          child: Column(
            children: [
              Text("Name", style: _descStyle),
              TextFormField(
                style: _editStyle,
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
                style: _editStyle,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (aValue) {
                  _data["desc"] = aValue;
                },
              ),
              Text("Cost", style: _descStyle),
              TextFormField(
                style: _editStyle,
                onSaved: (aValue) {
                  _data["cost"] = aValue;
                },
              ),
              Text("Date and time", style: _descStyle),
              TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(aContext,
                        showTitleActions: true,
                        minTime: DateTime(2000),
                        onConfirm: (DateTime aValue) {
                          _data["dateTime"] = aValue.toString();
                        },
                        currentTime: currentDateTime,
                        locale: LocaleType.ru);
                  },
                  child: Text(_data["dateTime"], style: _editStyle)),
              Text("Tag", style: _descStyle),
              // _buildDropDown(aContext, Icon(Icons.tag), aItems, "Tag")
            ],
          )),
    );
  }

  Widget _buildDropDown(BuildContext aContext, Icon aIcon,
      List<Tuple2<int, String>> aItems, String aID) {
    return DropdownButton<Tuple2<int, String>>(
      icon: aIcon,
      onChanged: (Tuple2<int, String> aItem) {
        setState(() {
          _data[aID] = aItem.item1;
        });
      },
      items: aItems.map<DropdownMenuItem>((Tuple2<int, String> aElement) {
        return DropdownMenuItem(value: aElement, child: Text(aElement.item2));
      }),
    );
  }

  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  Map<String, dynamic> _data;

  final TextStyle _editStyle = TextStyle(fontSize: 36);
  final TextStyle _descStyle = TextStyle(fontSize: 48);
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
