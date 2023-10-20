import 'package:dio/dio.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_rewards.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';

class RewardRepository {
  late UserRewards userRewards;

  late final GamiAcadDioClient _gamiAcadDioClient;

  RewardRepository({
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> getUserRewards({required String userId}) async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/user/$userId/reward',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        userRewards = UserRewards.fromJson(response.data);
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

  Future<Result> claimReward(
      {required String userId, required String rewardId}) async {
    try {
      var response = await _gamiAcadDioClient.put(
        path: '/reward/$rewardId/$userId',
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
