import 'dart:developer';
import 'package:dio/dio.dart';

import '../constants.dart';

class NetworkHelper {
  late Response response;
  Dio dio = Dio(BaseOptions(
    baseUrl: kAPI,
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ));

  Future getPost({int id = 1}) async {
    log('GET /posts/$id');
    response = await dio.get('/posts/$id');
    log('response: $response');
    return response.data;
  }
}
