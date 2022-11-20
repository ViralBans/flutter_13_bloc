// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fruit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fruit _$FruitFromJson(Map<String, dynamic> json) => Fruit(
      id: json['id'] as int,
      name: json['name'] as String,
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$FruitToJson(Fruit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost': instance.cost,
    };
