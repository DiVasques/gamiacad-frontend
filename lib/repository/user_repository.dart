import 'package:dio/dio.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/user.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';
import 'package:gami_acad/services/models/storage_keys.dart';
import 'package:gami_acad/services/secure_storage.dart';

class UserRepository {
  late User user;

  final SecureStorage _secureStorage = SecureStorage();
  final GamiAcadDioClient _gamiAcadDioClient = GamiAcadDioClient();

  Future<Result> addUser({
    required String id,
    required String name,
    required String email,
    required String registration,
  }) async {
    try {
      var response = await _gamiAcadDioClient.post(
        path: '/user/$id',
        body: {
          'name': name,
          'email': email,
          'registration': registration,
        },
        token: await _secureStorage.read(key: StorageKeys.accessToken),
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 201) {
        result.status = true;
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

  Future<Result> getUser({required String id}) async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/user/$id',
        token: await _secureStorage.read(key: StorageKeys.accessToken),
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        user = User.fromJson(response.data);
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (error.response?.statusCode == 403) {
        throw ForbiddenException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }
}
