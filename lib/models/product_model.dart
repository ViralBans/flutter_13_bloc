import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';

@freezed
class Product with _$Product {
  factory Product({required int id, required String name, required double cost}) = _Product;
}