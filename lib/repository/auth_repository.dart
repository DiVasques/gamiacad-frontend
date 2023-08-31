import 'dart:convert';

import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/user_access.dart';
import 'package:gami_acad/services/gamiacad_api_client.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/services/secure_storage.dart';

class AuthRepository {
  late UserAccess user;

  final SecureStorage _secureStorage = SecureStorage();

  Future<Result> loginUser({
    required String registration,
    required String password,
  }) async {
    var response = await GamiAcadAPIClient.post(
      path: '/login',
      body: {
        'registration': registration,
        'password': password,
      },
    );
    var result = Result(
      status: false,
      code: response.statusCode,
      message: response.reasonPhrase,
    );
    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }
    if (response.statusCode == 200) {
      user = UserAccess.fromJson(await json.decode(response.body));
      result.status = true;
      _secureStorage.write(key: 'accessToken', value: user.accessToken);
      _secureStorage.write(key: 'refreshToken', value: user.refreshToken);
      return result;
    }
    return result;
  }
}
