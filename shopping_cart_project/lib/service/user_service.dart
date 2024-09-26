import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shopping_cart_project/models/users.dart';
import 'package:shopping_cart_project/service/food_service.dart';

const userBaseUrl = 'http://172.16.13.249:8080/user';
final dio = Dio()
  ..interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      filter: (options, args) {
        //  return !options.uri.path.contains('posts');
        return !args.isResponse || !args.hasUint8ListData;
      },
    ),
  );

class UserService {
  Future<Map<String, dynamic>?> register(
      String name, String email, String password) async {
    var userData = {
      'name': name,
      'email': email,
      'password': password,
    };
    try {
      final response = await dio.post('$userBaseUrl/create', data: userData);
      if (response.statusCode == created) {
        print('User registered: ${response.data}');
      } else {
        print('Failed to register user: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<bool> login(String email, String password) async {
    var loginData = {
      'email': email,
      'password': password,
    };
    try {
      final response = await dio.post('$userBaseUrl/login', data: loginData);
      if (response.statusCode == success) {
        print('Login successful: ${response.data}');
        // trả về token sau khi login thành công, dùng token để get thông tin
        
        return true; // Indicate login success
      } else if (response.statusCode == unauthorized) {
        print('Invalid password');
      } else if (response.statusCode == notFound) {
        print('User not found');
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
  
  Future<User?> getUserIdBy(int userId) async {
    try{
    final response = await dio.get('$userBaseUrl/$userId');
    return User.fromJson(response.data);
  } catch (e) {
      print(e);
    }
    return null;
  }
}
