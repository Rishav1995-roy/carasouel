import 'dart:convert';

import 'package:carasouel/providers.dart';
import 'package:carasouel/userModel.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

class Repository {
  final Reader read;
  late Logger logger;

  Repository(this.read) {
    logger = read(loggerProvider);
  }

  Future<List<Results>> getResults() async {
    var dio = Dio();
    try {
      final response = await dio.get('https://randomuser.me/api/0.4/?randomapi');
      logger.d(response.data);
      Map valueMap = jsonDecode(response.data);
      logger.d(valueMap);
      final responseObj = BaseResponseModel.fromJson(valueMap);
      logger.d(responseObj.results);
      List<Results> results = [];
      responseObj.results.forEach((v) {
        final result = Results.fromMap(v);
        results.add(result);
      });
      logger.d(results);
      return results;
    } on DioError catch (e) {
      logger.d(e.response?.data);
      logger.e("${e.error.toString()}");
      return [];
    } catch (e) {
      logger.e("${e.toString()}");
      return [];
    }
  }
}
