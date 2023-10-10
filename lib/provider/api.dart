
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:front/data/model/user.dart';
import 'package:front/global/global.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



typedef EitherUser<T> = Future<Either<String, User>>;
typedef EitherToken<T> = Future<Either<String, String>>;
typedef EitherSuccess<T> = Future<Either<String, bool>>;


class Api extends GetxService {
  final isProduction = const bool.fromEnvironment('dart.vm.product');
  var dio = createDio();
  static var storage = GetStorage();
  final token = storage.read(StorageKeys.token.name);
  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://lawyernestjs-production.up.railway.app',
    ));
    dio.interceptors.addAll(
      [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // get token from storage
            final token = storage.read(StorageKeys.token.name);

            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {}
            return handler.next(options);
          },
        ),
        // RetryOnConnectionChangeInterceptor()
        // LogInterceptor(responseBody: true),
      ],
    );
    return dio;
  }

  EitherToken<String> login(String phone, String password) async {
    try {
      final data = {"phone": phone, "password": password};
      
      final res = await dio.post('/auth/login', data: data);
      
  

      if(res.statusCode == 201) {
        return right(res.data['token'] as String);
      }
      return left(res.data['message']);
    } catch (e) {
    
      return left(e.toString());
    }
  }

  EitherToken<String> register(
      String phone, String password, String firstName, String lastName) async {

        try {
    final data = {
      "phone": phone,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "userType": "lawyer"
    };
    final res = await dio.post('/auth/register', data: data);
    if(res.statusCode == 201) {
        return right(res.data['token']);
      }
      return left(res.data['message']);
    } catch (e) {
    
      return left(e.toString());
    }
  }

// user
 EitherUser<User> getUser() async {
    try {
      final res = await dio.get('/user/me');
      if(res.statusCode == 200) {
  
        return right(User.fromJson(res.data));
      }
      
      
      return left("Нэвтрэнэ үү.");
    } catch (e) {
      return left(e.toString());
    }
  }
}
