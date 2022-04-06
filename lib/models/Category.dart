import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Category.g.dart';

@HiveType(typeId: 4)
class Category extends Model {
  Category({
    required this.id,
    required this.name,
  });

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;


  @override
  List<Object?> get props => [id,name];

  Category copyWith({
    int? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class CategorySerializer implements Serializer<Category> {
  @override
  Category fromMap(Map<String, dynamic> map) {
    return Category(
        id: map["id"],
        name: map["name"]);
  }

  @override
  Map<String, dynamic> toMap(Category model) {
    return {
      "id" : model.id,
      "name" : model.name,
    };
  }
}
