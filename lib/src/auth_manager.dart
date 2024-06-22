import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  const AuthManager();

  static get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future authenticate({token}) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (token == null) {
      prefs.remove('token');
      return;
    }

    prefs.setString('token', token);
  }

  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return false;
    }

    return JWT.tryVerify(token, SecretKey('eriogheruitghoijghgbufhjg')) != null;
  }

  static Future<JWT?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return null;
    }

    return JWT.tryVerify(token, SecretKey('eriogheruitghoijghgbufhjg'));
  }


  static Future<dynamic> getUserCredentials() async {
    JWT? jwt = await getToken();

    if (jwt == null) {
      return null;
    }

    return jwt.header!['user'];
  }
}