import 'package:json_annotation/json_annotation.dart';

part 'fruit_model.g.dart';

@JsonSerializable()
class Fruit {
  final int id;
  final String name;
  final double cost;

  Fruit({required this.id, required this.name, required this.cost});

  factory Fruit.fromJson(Map<String, dynamic> json) => _$FruitFromJson(json);
  Map<String, dynamic> toJson() => _$FruitToJson(this);
}