class ExpenseModel {
  ExpenseModel(this._id, this._cost, this._name, this._desc, this._tag,
      this._owner, this._dateTime);

  Map<String, dynamic> toMapFull() {
    return {
      "id": _id,
      "dateTime": _dateTime.toString(),
      "desc": _desc,
      "name": _name,
      "tag": _tag,
      "owner": _owner,
      "cost": _cost,
    };
  }

  Map<String, dynamic> toMapWithoutID() {
    return {
      "dateTime": _dateTime.toString(),
      "desc": _desc,
      "name": _name,
      "tag": _tag,
      "owner": _owner,
      "cost": _cost,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> aData) {
    return new ExpenseModel(
        aData["id"],
        aData["cost"],
        aData["desc"],
        aData["name"],
        aData["tag"],
        aData["owner"],
        DateTime.parse(aData["dateTime"]));
  }

  int get id => _id;

  double get cost => _cost;

  String get name => _name;

  String get desc => _desc;

  int get tag => _tag;

  int get owner => _owner;

  DateTime get dateTime => _dateTime;

  int _id;
  double _cost;
  String _name;
  String _desc;

  int _tag;

  int _owner;
  DateTime _dateTime;
}
