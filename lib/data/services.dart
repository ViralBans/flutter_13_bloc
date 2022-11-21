import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../business/functions.dart';
import '../models/fruit_model.dart';

@LazySingleton()
class DataNetwork {
  final dataUrl = 'https://run.mocky.io/v3/ec49fec5-7437-46c4-98b3-c4ec823eca77';
  late List<Fruit> fruit;

  Stream<List<Fruit>> getData() async* {
    try {
      final response = await Dio().get(dataUrl);
      if(response.statusCode == 200) {
        fruit = response.data.map<Fruit>((fruit) => Fruit.fromJson(fruit)).toList();
        for (var element in fruit) {
          GetIt.I.get<Basket>().select[element.name] = element.isSelected;
        }
        yield fruit;
      } else {
        throw Exception('Ошибка загрузки данных!');
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
  }
}