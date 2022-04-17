class Note {
  late int _id;
  late String _title;
  late String? _description;
  late String _date;


  Note(this._id, this._title, this._date, 
      [this._description]);

  Note.withId(this._id, this._title, this._date,
      [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description ?? '';

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _date = map['date'];
  }
}
