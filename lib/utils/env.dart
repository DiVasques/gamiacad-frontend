import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get gamiacadApiUrl => _get('GAMIACAD_API_URL');
  static String get clientId => _get('CLIENT_ID');

  static String _get(String envName) => dotenv.get(envName);
}
