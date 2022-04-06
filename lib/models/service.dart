class Service {
  Service(
      this.id,
      this.title,
      this.icon,
      );

  String title;
 String id;
 String icon;



  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      json['_id'].toString(),
      json['name'].toString(),
      json['icon'].toString(),
    );
  }
}
