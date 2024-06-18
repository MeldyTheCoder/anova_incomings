import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthManager {
  const AuthManager();

  static const secureStorage = FlutterSecureStorage();

  static Future authenticate({token}) async {
    await secureStorage.write(key: 'token', value: token);
  }

  static Future<bool> isAuthenticated() async {
    String? token = await secureStorage.read(key: 'token');

    if (token == null) {
      return false;
    }

    return JWT.tryVerify(token, SecretKey('SECRET_KEY')) != null;
  }

  static Future<JWT?> getToken() async {
    String? token = await secureStorage.read(key: 'token');

    if (token == null) {
      return null;
    }

    return JWT.tryVerify(token, SecretKey('SECRET_KEY'));
  }

  static Future<Record?> getUserCredentials() async {
    JWT? jwt = await getToken();

    if (jwt == null) {
      return null;
    }

    return jwt.header!['user'];
  }
}