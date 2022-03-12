import 'dart:convert';
import 'package:dio/dio.dart';
import 'app_exception.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await Dio().get(url);
      switch (response.statusCode) {
        case 200:
          responseJson = response.data;
          return responseJson;
        case 400:
          throw BadRequestException(response.data.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.data.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }
}
