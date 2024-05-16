import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'end_point.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        }));
  }

  Future<Response> getData({required String endPoint}) async {
    try {
      Response response = await dio.get(endPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      dio.options.headers = {"Authorization": "Bearer ${token ?? ""}"};
      Response response =
          await dio.post(endPoint, data: data, queryParameters: query);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
