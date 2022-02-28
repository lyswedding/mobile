class TaskList {
  TaskList(
      this.id,
      this.title,
      this.description,
      this.date,
      this.status,
      this.archived,
      //this.questions,
      this.sections,
      );

  String id;
  String title;
  String description;
  String date;
  bool status;
  bool archived;
  //List<Question> questions;
  List<Section> sections;

  factory FormulaireSection.fromJson(Map<String, dynamic> json) {
    //var listq = json['questions'] as List;
    var lists=json['sections']as List;

    List<Section> sectionsList =
    lists.map((i) => Section.fromJson(i)).toList();

    DateTime dateTime = DateTime.parse(json['created_date'].toString());
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return FormulaireSection(
      json['_id'].toString(),
      json['title'].toString(),
      json['description'].toString(),
      formattedDate,
      json['status'],
      json['archived'],
      sectionsList,
    );
  }
}
class Section {
  Section(
      this.title,
      this.description,
      this.next,
      this.questions,
      );

  String title;
  String description;
  String next;
  List<Question> questions;

  factory Section.fromJson(Map<String, dynamic> json) {
    var listO = json['questions'] as List;

    List<Question> questionsList = listO.map((i) => Question.fromJson(i)).toList();

    return Section(
      json['title'].toString(),
      json['description'].toString(),
      json['next'].toString(),
      questionsList,
    );
  }
}
