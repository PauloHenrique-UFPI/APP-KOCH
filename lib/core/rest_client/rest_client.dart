
abstract class RestClient {
  Future<List> get(String path, {Map<String, dynamic>? params});
  Future<Map> post(String path, Map<String, dynamic> data);
  Future<Map> put(String path, Map<String, dynamic> data);
  Future<Map> delete(String path);
}
