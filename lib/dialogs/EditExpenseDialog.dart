import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class EditExpenseDialogState extends State<EditExpenseDialog> {
  @override
  Widget build(BuildContext aContext) {
    var currentDateTime =
        DateFormat("dd-MM-yyyy HH:mm").parse(widget._data["dateTime"]);
    return Scaffold(
      appBar: AppBar(title: Text("Edit expense")),
      body: Form(
        key: _formState,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget._data["name"],
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Name",
              ),
              validator: (aValue) {
                if (aValue.isEmpty) {
                  return "Name is emprty";
                }
                return null;
              },
              style: _editStyle,
              onSaved: (aValue) {
                widget._data["name"] = aValue;
              },
            ),
            TextFormField(
              initialValue: widget._data["desc"],
              decoration: InputDecoration(
                hintText: "Description",
                labelText: "Description",
              ),
              style: _editStyle,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              onSaved: (aValue) {
                widget._data["desc"] = aValue;
              },
            ),
            TextFormField(
              initialValue: widget._data["cost"].toString(),
              decoration: InputDecoration(
                hintText: "Cost",
                labelText: "Cost",
              ),
              style: _editStyle,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: false),
              onSaved: (aValue) {
                var doubleValue = double.tryParse(aValue);
                if (doubleValue != null) {
                  widget._data["cost"] = doubleValue;
                }
              },
              validator: (aValue) {
                var doubleValue = double.tryParse(aValue);
                if (doubleValue == null) {
                  return "Cost is empty";
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date and time", style: _descStyle),
                TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      aContext,
                      showTitleActions: true,
                      onConfirm: (DateTime aValue) {
                        setState(() {
                          widget._data["dateTime"] =
                              DateFormat("dd-MM-yyyy HH:mm").format(aValue);
                        });
                      },
                      currentTime: currentDateTime,
                      locale: LocaleType.ru,
                    );
                  },
                  child: Text(
                    widget._data["dateTime"],
                    style: _dateTimeStyle,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formState.currentState.validate()) {
                      _formState.currentState.save();
                      if (widget._data["id"] == -1) {
                        ExpenseDB()
                            .addExpense(ExpenseModel.fromMap(widget._data))
                            .then((value) => Navigator.pop(aContext));
                      } else {
                        ExpenseDB()
                            .updateExpenseByID(widget._data["id"],
                                ExpenseModel.fromMap(widget._data))
                            .then((value) => Navigator.pop(aContext));
                      }
                    }
                  },
                  child: Text("Submit"),
                )
              ],
            )
            // Text("Tag", style: _descStyle),
            // _buildDropDown(aContext, Icon(Icons.tag), aItems, "Tag")
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown(BuildContext aContext, Icon aIcon,
      List<Tuple2<int, String>> aItems, String aID) {
    return DropdownButton<Tuple2<int, String>>(
      icon: aIcon,
      onChanged: (Tuple2<int, String> aItem) {
        setState(() {
          widget._data[aID] = aItem.item1;
        });
      },
      items: aItems.map<DropdownMenuItem>((Tuple2<int, String> aElement) {
        return DropdownMenuItem(value: aElement, child: Text(aElement.item2));
      }),
    );
  }

  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextStyle _editStyle = TextStyle(fontSize: 24);
  final TextStyle _descStyle = TextStyle(fontSize: 24);

  final TextStyle _dateTimeStyle = TextStyle(fontSize: 18);
}

class EditExpenseDialog extends StatefulWidget {
  EditExpenseDialog({aExpenseID = -1}) {
    if (aExpenseID == -1) {
      _data = {
        "id": -1,
        "dateTime": DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()),
        "desc": "",
        "name": "",
        "owner": 0,
        "cost": null,
      };
    } else {
      var oldModel = ExpenseDB().getExpenseByID(aExpenseID);
      _data = oldModel.toMapFull();
    }
  }

  @override
  State<StatefulWidget> createState() {
    return EditExpenseDialogState();
  }

  Map<String, dynamic> _data;
  int _expenseID = -1;
}
