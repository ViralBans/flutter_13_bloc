import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/fruit_model.dart';

@LazySingleton()
class DataNetwork {
  late List<Fruit> fl;

  Future<List<Fruit>> getFruitList() async {
    try {
      Response response = await Dio()
          .get('https://run.mocky.io/v3/ec49fec5-7437-46c4-98b3-c4ec823eca77');
      fl =
          response.data.map<Fruit>((fruits) => Fruit.fromJson(fruits)).toList();
      return fl;
    } on DioError catch (e) {
      throw Exception(e.error);
    }
  }
}