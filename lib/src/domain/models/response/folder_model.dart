class FolderModel {
  final int id;
  final String name;
  final DateTime createdAt;
  FolderModel({required this.id, required this.name, required this.createdAt});

  FolderModel copyWith({int? id, String? name, DateTime? createdAt}) {
    return FolderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory FolderModel.mockData() {
    return FolderModel(createdAt: DateTime.now(), id: 1, name: "mock");
  }
}
