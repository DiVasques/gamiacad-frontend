import 'package:dio/dio.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/exceptions/user_exists_exception.dart';
import 'package:gami_acad/repository/models/user_access.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';
import 'package:gami_acad/services/models/storage_keys.dart';
import 'package:gami_acad/services/secure_storage.dart';

class AuthRepository {
  late UserAccess user;

  final SecureStorage _secureStorage = SecureStorage();
  final GamiAcadDioClient _gamiAcadDioClient = GamiAcadDioClient();

  Future<Result> loginUser({
    required String registration,
    required String password,
  }) async {
    try {
      var response = await _gamiAcadDioClient.post(
        path: '/login',
        body: {
          'registration': registration,
          'password': password,
        },
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        user = UserAccess.fromJson(response.data);
        result.status = true;
        await _saveUserAccess(user);
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }

  Future<Result> signUpUser({
    required String registration,
    required String password,
  }) async {
    try {
      var response = await _gamiAcadDioClient.post(
        path: '/signup',
        body: {
          'registration': registration,
          'password': password,
        },
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 201) {
        user = UserAccess.fromJson(response.data);
        result.status = true;
        await _saveUserAccess(user);
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (error.response?.statusCode == 409) {
        throw UserExistsException();
      }
      throw ServiceUnavailableException();
    }
  }

  Future<void> _saveUserAccess(UserAccess user) async {
    await _secureStorage.write(key: StorageKeys.userId, value: user.id);
    await _secureStorage.write(
        key: StorageKeys.accessToken, value: user.accessToken);
    await _secureStorage.write(
        key: StorageKeys.refreshToken, value: user.refreshToken);
  }
}
