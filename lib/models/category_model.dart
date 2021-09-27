class Category {
  String name;
  String displayName;
  String iconURL;

  Category({required this.name, required this.displayName, required this.iconURL});

  Category.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        displayName = parsedJSON['displayName'],
        iconURL = parsedJSON['iconURL'];
}