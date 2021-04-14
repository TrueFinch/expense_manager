import 'package:expense_manager/models/ExpenseDB.dart';
import 'package:expense_manager/models/ExpenseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListItem extends StatefulWidget {
  ExpenseListItem({this.index, this.data});

  final ExpenseDB _db = ExpenseDB();
  final int index;
  final ExpenseModel data;
  final TextStyle _dateStyle = TextStyle(
    fontSize: 18,
  );
  final TextStyle _costStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  @override
  _ExpenseListItemState createState() => _ExpenseListItemState(data);
}

class _ExpenseListItemState extends State<ExpenseListItem> {
  _ExpenseListItemState(ExpenseModel aData) {
    ExpenseDB().getTagByID(aData.tag).then((aValue) => setState(() {
          _tagText = aValue;
        }));
    ExpenseDB().getOwnerByID(aData.owner).then((aValue) => setState(() {
          _ownerText = aValue;
        }));
  }

  // @formatter:on
  @override
  Widget build(BuildContext aContext) {
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat("dd-MM-yyyy — HH:mm").format(widget.data.dateTime),
              style: widget._dateStyle,
            ),
            // if (_ownerText != "no_name")
            Row(
              children: [
                Icon(Icons.account_box),
                Text(_ownerText),
              ],
            ),
            if (_tagText.isNotEmpty) Text(_tagText),
          ],
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.data.cost.toString(),
              style: widget._costStyle,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(widget.data.name), Text(widget.data.desc)])
          ],
        ))
      ],
    );
    return Dismissible(
        key: Key("${widget.data.id}"),
        child: Card(
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5), child: content),
        ));
  }

  // @formatter:on

  ExpenseModel data;
  String _tagText = "";
  String _ownerText = "";
}
