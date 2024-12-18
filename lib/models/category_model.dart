class CategoryModel {
  String id;
  String name;
  String imagePath;

  CategoryModel(
      {required this.id, required this.name, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CategoryModel(
      id: documentId,
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}
