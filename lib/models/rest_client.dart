import 'package:dio/dio.dart';

abstract class RestClient {
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? params});
  Future<Map> post(String path, Map<String, dynamic> data);
  Future<Map> patch(String path, Map<String, dynamic> data);
  Future<Response> delete(String path, int id);
}
