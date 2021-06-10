class AnnotationModel {
  int? id;
  late final String title;
  late final String description;
  late final String date;

  AnnotationModel(
      {required this.title, required this.description, required this.date});

  AnnotationModel.fromMap(Map map) {
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
    this.date = map["date"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "title": this.title,
      "description": this.description,
      "date": this.date,
    };

    if (this.id != null) {
      map["id"] = this.id;
    }

    return map;
  }
}
