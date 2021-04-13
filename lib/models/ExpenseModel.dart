class ExpenseModel {
  ExpenseModel(this._id, this._cost, this._name, this._desc, this._tag,
      this._owner, this._dateTime);

  Map<String, dynamic> toMapFull() {
    return {
      "id": _id,
      "dateTime": _dateTime,
      "desc": _desc,
      "name": _name,
      "tag": _tag,
      "owner": _owner,
      "cost": _cost,
    };
  }

  Map<String, dynamic> toMapWithoutID() {
    return {
      "dateTime": _dateTime,
      "desc": _desc,
      "name": _name,
      "tag": _tag,
      "owner": _owner,
      "cost": _cost,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> aData) {
    return new ExpenseModel(aData["id"], aData["dateTime"], aData["desc"],
        aData["name"], aData["tag"], aData["owner"], aData["cost"]);
  }

  int get id => _id;

  int get cost => _cost;

  String get name => _name;

  String get desc => _desc;

  //todo change type to int
  String get tag => _tag;

  //todo change type to int
  String get owner => _owner;

  DateTime get dateTime => _dateTime;

  int _id;
  int _cost;
  String _name;
  String _desc;

  //todo change type to int
  String _tag;

  //todo change type to int
  String _owner;
  DateTime _dateTime;
}
