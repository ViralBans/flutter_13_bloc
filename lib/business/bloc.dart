import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'functions.dart';

@injectable
class SimpleBloc {

  // Для счетчика товаров в корзине
  final _countInputEventController = StreamController();
  final _countOutputStateController = StreamController<int>();
  StreamSink get countAction => _countInputEventController.sink;
  Stream<int> get countState => _countOutputStateController.stream;

  // Для формирования списка продуктов в корзине
  final _listInputEventController = StreamController();
  final _listOutputStateController = StreamController<List<String>>();
  StreamSink get listAction => _listInputEventController.sink;
  Stream<List<String>> get listState => _listOutputStateController.stream;

  // Для добавления элементов в корзину
  final _elementInputEventController = StreamController<String>();
  final _elementOutputStateController = StreamController<bool>();
  StreamSink<String> get elementAction => _elementInputEventController.sink;
  Stream<bool> get elementState => _elementOutputStateController.stream;

  void _getCount(void v) async {
    _countOutputStateController.sink.add(GetIt.I.get<Basket>().ls.length);
  }

  void _getList(void v) async {
    _listOutputStateController.sink.add(GetIt.I.get<Basket>().ls);
  }

  void _changeElementInBasket(String s) async {
    if(GetIt.I.get<Basket>().ls.contains(s)) {
      GetIt.I.get<Basket>().ls.remove(s);
      _elementOutputStateController.sink.add(GetIt.I.get<Basket>().ls.contains(s));
    } else {
      GetIt.I.get<Basket>().ls.add(s);
      _elementOutputStateController.sink.add(GetIt.I.get<Basket>().ls.contains(s));
    }
  }

  SimpleBloc() {
    _countInputEventController.stream.listen(_getCount);
    _listInputEventController.stream.listen(_getList);
    _elementInputEventController.stream.listen(_changeElementInBasket);
  }

  void dispose() {
    _countInputEventController.close();
    _listInputEventController.close();
    _elementInputEventController.close();
    _countOutputStateController.close();
    _listOutputStateController.close();
    _elementOutputStateController.close();
  }
}