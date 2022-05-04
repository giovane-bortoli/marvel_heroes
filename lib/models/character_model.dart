class CharacterModel {
  final int id;
  final String name;
  final String description;
  final thumbnailModel thumbnail;

  CharacterModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnail});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: thumbnailModel.fromJson(json['thumbnail']));
  }
}

class thumbnailModel {
  final String path;
  final String extension;

  thumbnailModel({required this.path, required this.extension});

  factory thumbnailModel.fromJson(Map<String, dynamic> json) {
    return thumbnailModel(
      path: json['path'],
      extension: json['extension'],
    );
  }
}
