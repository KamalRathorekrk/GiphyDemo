import 'dart:io';

import 'package:demo21/model/giphy_model.dart';
import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiProvider {
  Dio _dio = Dio();
  DioError? _dioError;

  ApiProvider.base() {
    BaseOptions dioOptions = BaseOptions()
      ..baseUrl = baseUrl;

    _dio = Dio(dioOptions);
  }

//Treding URL
  Future funLoadTrendingGiphy() async {
    try {
      Response response = await _dio.get(trndingURL);
      return Giphy_Model.fromJson(response.data!);
    } catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }
  // search giphy
  Future funSearchGiphy({querry}) async {
    try {
      Response response = await _dio.get("$searchURL$querry");
      return Giphy_Model.fromJson(response.data!);
    } catch (error, stacktrace) {
      handleException(error, stacktrace, _dioError!);
    }
  }

}
