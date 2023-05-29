import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koch_app/models/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient extends RestClient {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://api-koch.onrender.com'));

  @override
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? params}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');
    final response = await dio.get(path,
        queryParameters: params,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-Type': 'application/json'
        }));
    return response.data;
  }

  @override
  Future<Map> post(String path, Map<String, dynamic> data) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');
    final response = await dio.post(path,
        data: data,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-Type': 'application/json'
        }));
    return response.data;
  }

  @override
  Future<Map> patch(String path, Map<String, dynamic> data) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');
    final response = await dio.patch(path,
        data: data,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'content-Type': 'application/json'
        }));
    return response.data;
  }

  @override
  Future<Response> delete(String path, int id) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');

    try {
      final response = await dio.delete('$path/:$id',
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            'content-Type': 'application/json'
          }));
      return response.data;
    } catch (e) {
      print('Erro $e');
      rethrow;
    }
  }
}
