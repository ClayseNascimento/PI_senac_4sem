import 'package:dio/dio.dart';
import 'package:todolist/src/@shared/interceptors/http_client.dart';

class DioHttpClient implements IHttpClient {
  late Dio _instance;

  DioHttpClient() {
    _onCreate();
  }

  Future<ResponseModel> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? extra}) async {
    Response response = await _instance.get(
      path,
      queryParameters: queryParameters,
      options: Options(extra: extra),
    );
    return ResponseModel(data: response.data, statusCode: response.statusCode);
  }

  Future<ResponseModel> post(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? extra}) async {
    Response response =
        await _instance.post(path, data: data, queryParameters: queryParameters, options: Options(extra: extra));
    return ResponseModel(data: response.data, statusCode: response.statusCode);
  }

  Future<ResponseModel> put(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? extra}) async {
    Response response = await _instance.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: extra),
    );
    return ResponseModel(data: response.data, statusCode: response.statusCode);
  }

  Future<ResponseModel> delete(String path,
      {data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? extra}) async {
    Response response = await _instance.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(extra: extra),
    );
    return ResponseModel(data: response.data, statusCode: response.statusCode);
  }

  void _onCreate() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://localhost:3333",
      connectTimeout: 60000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      headers: {"content-type": 'application/json'}
    );
    _instance = Dio(options);
  }

  Dio get dio => _instance;
}
