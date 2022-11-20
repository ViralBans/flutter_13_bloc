import 'package:injectable/injectable.dart';

import '../models/product_model.dart';

@LazySingleton()
class Basket {
  final Map<int, Product> _basketList = {};

  List<String> ls = [];

  void addItem(int id, String name, double cost) {
    _basketList.addAll({id : Product(id: id, name: name, cost: cost)});
  }

  void deleteItem(int id) {
    _basketList.remove(id);
  }

  bool checkItemInBasket(int id) {
    return _basketList.containsKey(id);
  }

  int getBasketItems() {
    return _basketList.length;
  }

  void changeTrailing(int id, String name, double cost) {
    if (checkItemInBasket(id)) {
      deleteItem(id);
      ls.remove(name);
    } else {
      addItem(id, name, cost);
      ls.add(name);
    }
  }
}