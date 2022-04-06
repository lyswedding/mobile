class InsertUser {
  String displayName;
  String email;
  String photoUrl;
  InsertUser(
      {required this.displayName, required this.email, required this.photoUrl});

  Map<String, dynamic> toJson() {
    return {"displayName": displayName, "email": email, "photoUrl": photoUrl};
  }
}

class APIResponse<T> {
  T? data;
  bool error;
  String? errorMessage;
  APIResponse({this.data, this.errorMessage, this.error = false});
}
