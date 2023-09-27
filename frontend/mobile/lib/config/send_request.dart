import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? '';

final options = BaseOptions(
  baseUrl: baseUrl,
);

Future<dynamic> sendRequest(
    String route, String method, Map<String, dynamic> payload) async {
  var dio = Dio(options);
  dynamic responseData;
  Response response;
  String json = jsonEncode(payload);

  try {
    switch (method.toLowerCase()) {
      case 'post':
        print(json);
        response = await dio.post(route, data: json);
        break;
      case 'get':
        response = await dio.get(route);
      default:
        throw Exception(
            "Bad method -- Please consider using a proper http method");
    }
  } catch (e) {
    rethrow;
  }

  responseData = response.data;
  return responseData;
}
