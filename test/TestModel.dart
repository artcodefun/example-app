import 'package:flutter/material.dart';
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/models/abstract/Serializer.dart';

class TestModel extends Model {
  @override
  final int id;
  final String name;
  final double height;

  @override
  List<Object?> get props => [id, name, height];

  TestModel({
    required this.id,
    required this.name,
    required this.height,
  });

  TestModel copyWith({
    int? id,
    String? name,
    double? height,
  }) {
    return TestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
    );
  }
}

class TestModelSerializer implements Serializer<TestModel> {
  @override
  TestModel fromMap(Map<String, dynamic> map) {
    return TestModel(id: map["id"], name: map["name"], height: map["height"]);
  }

  @override
  Map<String, dynamic> toMap(TestModel model) {
    return {
      "id": model.id,
      "name": model.name,
      "height": model.height
    };
  }
}
