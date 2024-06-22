import 'package:anova_incomings/src/auth_manager.dart';
import 'package:dio/dio.dart';


typedef TUser = ({
  int id, 
  String username, 
  String password, 
  String email,
});

typedef TTokenData = ({
    String access_token,
    String token_type,
});

typedef TLoginResponse = ({
  TUser user,
  TTokenData token,
});


final dio = Dio();


class ApiManager {
  static Future<bool> deleteIncoming(int incomingId) async {
    final urlString = 'http://192.168.0.133:8080/history/$incomingId/';
    final token = await AuthManager.token;

    final response = await dio.delete(
      urlString,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      )
    );

    switch (response.statusCode) {
      case 200:
        return response.data.isNotEmpty;

      case 400:
        throw response.data['detail'] 
          ?? 
          'Ошибка авторизации. Повторите попытку позднее.';
      default:
        throw 'Неизвестный ответ от сервера.';
    }
  }

  static Future<List<dynamic>> getIncomings() async {
    const urlString = 'http://192.168.0.133:8080/history/';
    
    final token = await AuthManager.token;

    final response = await dio.get(
      urlString,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ),
    );

    final decodedResponse = response.data;

    switch (response.statusCode) {
      case 200:
        return decodedResponse;

      case 400:
        throw decodedResponse['detail'] 
          ?? 
          'Ошибка авторизации. Повторите попытку позднее.';
      default:
        throw 'Неизвестный ответ от сервера.';
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    const urlString = 'http://192.168.0.133:8080/users/token/';

    final response = await dio.post(
      urlString,
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        contentType: "application/x-www-form-urlencoded",
      ),
    );

    final decodedResponse = response.data;

    switch (response.statusCode) {
      case 200:
        return decodedResponse;

      case 400:
        throw decodedResponse['detail'] 
          ?? 
          'Ошибка авторизации. Повторите попытку позднее.';

      default:
        throw 'Неизвестный ответ от сервера.';
    }
  }

  static Future<Map<String, dynamic>> registration(String username, String email, String password) async {
    const urlString = 'http://192.168.0.133:8080/users/registration/';

    final response = await dio.post(
      urlString,
      data: {
        'username': username,
        'password': password,
        'email': email,
      },
    );

    final decodedResponse = response.data;

    switch (response.statusCode) {
      case 200:
        return decodedResponse;

      case 400:
        throw decodedResponse['detail'] 
          ?? 
          'Ошибка регистрации. Повторите попытку позднее.';

      default:
        throw 'Неизвестный ответ от сервера.';
    }
  }

  static Future<Map> createIncoming(String title, int price, String category, String type) async {
    const urlString = 'http://192.168.0.133:8080/history/create';
    final token = await AuthManager.token;

    final requestBody = {
      'title': title,
      'price': price,
      'category': category,
      'type': type,
    };
    
    final response = await dio.put(
      urlString,
      data: requestBody,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        },
      ),
    );

    final decodedResponse = response.data;

    switch (response.statusCode) {
      case 200:
        return decodedResponse;

      case 400:
        throw decodedResponse['detail'] 
          ?? 
          'Ошибка создания записи. Повторите попытку позднее.';

      default:
        throw 'Неизвестный ответ от сервера.';
    }
  }
}