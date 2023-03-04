import 'package:dio/dio.dart';
import 'package:koch_app/core/rest_client/rest_client.dart';

class DioClient extends RestClient {
  final dio = Dio(BaseOptions(baseUrl: 'https://api-tb-koch.onrender.com'));

  @override
  Future<List> get(String path, {Map<String, dynamic>? params}) async {
    final response = await dio.get(path, queryParameters: params);
    return response.data;
  }

  @override
  Future<Map> post(String path, Map<String, dynamic> data) async {
    final response = await dio.post(path, data: data);
    return response.data;
  }

  @override
  Future<Map> put(String path, Map<String, dynamic> data) async {
    final response = await dio.post(path, data: data);
    return response.data;
  }

  @override
  Future<Map> delete(String path) {
    throw UnimplementedError();
  }
}
