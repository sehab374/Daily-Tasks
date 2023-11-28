class UserModel {
  String id;
  String name;
  String email;
  int age;


  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.age});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            age: json["age"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age
    };
  }
}
