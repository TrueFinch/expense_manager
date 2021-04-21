import 'package:intl/intl.dart';

class ExpenseModel {
  ExpenseModel(this._id, this._cost, this._name, this._desc,
      this._owner, this._dateTime);

  Map<String, dynamic> toMapFull() {
    return {
      "id": _id,
      "dateTime": DateFormat("dd-MM-yyyy HH:mm").format(_dateTime),
      "desc": _desc,
      "name": _name,
      "owner": _owner,
      "cost": _cost,
    };
  }

  Map<String, dynamic> toMapWithoutID() {
    return {
      "dateTime": DateFormat("dd-MM-yyyy HH:mm").format(_dateTime),
      "desc": _desc,
      "name": _name,
      "owner": _owner,
      "cost": _cost,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> aData) {
    var model = new ExpenseModel(
        aData["id"],
        aData["cost"],
        aData["name"],
        aData["desc"],
        aData["owner"],
        DateFormat("dd-MM-yyyy HH:mm").parse(aData["dateTime"]));
    return model;
  }

  int get id => _id;

  double get cost => _cost;

  String get name => _name;

  String get desc => _desc;

  int get owner => _owner;

  DateTime get dateTime => _dateTime;

  int _id;
  double _cost;
  String _name;
  String _desc;
  int _owner;
  DateTime _dateTime;
}
