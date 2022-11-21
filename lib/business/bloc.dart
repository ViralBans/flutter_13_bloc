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

  // Изменение кнопки
  final _buttonInputEventController = StreamController<String>();
  final _buttonOutputStateController = StreamController<bool>();
  StreamSink<String> get buttonAction => _buttonInputEventController.sink;
  Stream<bool> get buttonState => _buttonOutputStateController.stream;

  void _getCount(void v) async {
    _countOutputStateController.sink.add(GetIt.I.get<Basket>().basket.length);
  }

  void _getList(void v) async {
    _listOutputStateController.sink.add(GetIt.I.get<Basket>().basket);
  }

  void _updateElementInBasket(String s) async {
    if(GetIt.I.get<Basket>().basket.contains(s)) {
      GetIt.I.get<Basket>().basket.remove(s);
      _elementOutputStateController.sink.add(false);
    } else {
      GetIt.I.get<Basket>().basket.add(s);
      _elementOutputStateController.sink.add(true);
    }
  }

  void _updateButton(String s) async {
    if(GetIt.I.get<Basket>().select[s] == false) {
      GetIt.I.get<Basket>().select[s] = true;
    } else {
      GetIt.I.get<Basket>().select[s] = false;
    }
    bool get = GetIt.I.get<Basket>().select[s]!;
    _buttonOutputStateController.sink.add(get);
  }

  SimpleBloc() {
    _countInputEventController.stream.listen(_getCount);
    _listInputEventController.stream.listen(_getList);
    _elementInputEventController.stream.listen(_updateElementInBasket);
    _buttonInputEventController.stream.listen(_updateButton);
  }

  void dispose() {
    _countInputEventController.close();
    _listInputEventController.close();
    _elementInputEventController.close();
    _buttonInputEventController.close();
    _countOutputStateController.close();
    _listOutputStateController.close();
    _elementOutputStateController.close();
    _buttonOutputStateController.close();
  }
}