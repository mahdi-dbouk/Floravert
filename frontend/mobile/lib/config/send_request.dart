import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? '';

Future<dynamic> sendRequest(String route, String method,
    Map<String, dynamic>? payload, String? token) async {
  final options = BaseOptions(baseUrl: baseUrl, headers: {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  });
  var dio = Dio(options);
  dynamic responseData;
  Response response;
  String json = jsonEncode(payload);

  try {
    switch (method.toLowerCase()) {
      case 'post':
        response = await dio.post(route, data: json);
        break;
      case 'get':
        response = await dio.get(route, data: json);
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
