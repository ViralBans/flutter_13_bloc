import 'package:injectable/injectable.dart';

@LazySingleton()
class Basket {
  List<String> basket = [];
  Map<String, bool> select = {};
}