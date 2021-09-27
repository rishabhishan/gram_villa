class UserModel {
  String name;
  String age;

  UserModel({required this.name, required this.age});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        age = parsedJSON['age'];
}