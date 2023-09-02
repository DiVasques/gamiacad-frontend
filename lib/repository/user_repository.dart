import 'package:gami_acad/services/gamiacad_api_client.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/services/models/storage_keys.dart';
import 'package:gami_acad/services/secure_storage.dart';

class UserRepository {
  final SecureStorage _secureStorage = SecureStorage();

  Future<Result> addUser({
    required String id,
    required String name,
    required String email,
  }) async {
    var response = await GamiAcadAPIClient.post(
      path: '/user/$id',
      body: {
        'name': name,
        'email': email,
      },
      token: await _secureStorage.read(key: StorageKeys.accessToken),
    );
    var result = Result(
      status: false,
      code: response.statusCode,
      message: response.reasonPhrase,
    );
    if (response.statusCode == 201) {
      result.status = true;
      return result;
    }
    return result;
  }
}
