import 'package:dio/dio.dart';
import 'package:gami_acad/services/models/storage_keys.dart';
import 'package:gami_acad/services/secure_storage.dart';
import 'package:gami_acad/utils/env.dart';

class GamiAcadDioClient {
  static final GamiAcadDioClient _instance = GamiAcadDioClient._internal();
  final SecureStorage _secureStorage = SecureStorage();

  static final _baseUrl = Env.gamiacadApiUrl;
  static final _clientId = Env.clientId;

  factory GamiAcadDioClient() {
    return _instance;
  }

  late Dio _dio;

  GamiAcadDioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        contentType: 'application/json',
        headers: <String, String>{'Accept': '*/*', 'clientId': _clientId},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] =
              'Bearer ${await _secureStorage.read(key: StorageKeys.accessToken)}';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 &&
              !e.requestOptions.path.contains('login')) {
            try {
              await _refreshToken();
            } on DioException catch (e) {
              handler.reject(e);
              return;
            }
            String? newAccessToken =
                await _secureStorage.read(key: StorageKeys.accessToken);

            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            return handler.resolve(await _dio.fetch(e.requestOptions));
          }
          return handler.reject(e);
        },
      ),
    );
  }

  Future<Response> post({
    required String path,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.post(
      path,
      queryParameters: query,
      data: body,
    );
  }

  Future<Response> get({
    required String path,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(path, queryParameters: query);
  }

  Future<void> _refreshToken() async {
    Response response = await _dio.post('/login/refresh', data: {
      'token': await _secureStorage.read(key: StorageKeys.refreshToken)
    });
    if (response.statusCode == 200) {
      await _secureStorage.write(
          key: StorageKeys.userId, value: response.data['userId']);
      await _secureStorage.write(
          key: StorageKeys.accessToken, value: response.data['accessToken']);
      await _secureStorage.write(
          key: StorageKeys.refreshToken, value: response.data['refreshToken']);
    }
  }
}
