import 'package:json_annotation/json_annotation.dart';

part 'fruit_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Fruit {
  final int id;
  final String name;
  final double cost;

  @JsonKey(defaultValue: false)
  bool isSelected;

  Fruit({required this.id, required this.name, required this.cost, required this.isSelected});

  factory Fruit.fromJson(Map<String, dynamic> json) => _$FruitFromJson(json);
  Map<String, dynamic> toJson() => _$FruitToJson(this);
}