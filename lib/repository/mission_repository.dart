import 'package:dio/dio.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_missions.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';

class MissionRepository {
  late UserMissions userMissions;

  late final GamiAcadDioClient _gamiAcadDioClient;

  MissionRepository({
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> getUserMissions({required String userId}) async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/user/$userId/mission',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        userMissions = UserMissions.fromJson(response.data);
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

  Future<Result> subscribeOnMission(
      {required String userId, required String missionId}) async {
    try {
      var response = await _gamiAcadDioClient.put(
        path: '/mission/$missionId/$userId',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 204) {
        result.status = true;
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
