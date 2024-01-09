import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:front/data/data.dart';
import 'package:front/data/model/user.dart';
import 'package:front/global/global.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef EitherUser<T> = Future<Either<String, User>>;
typedef EitherResponse<T> = Future<Either<String, ResponseModel>>;
typedef EitherToken<T> = Future<Either<String, String>>;
typedef EitherSuccess<T> = Future<Either<String, bool>>;

class StreamSocket {
  final _socketResponse = StreamController<List<Message>?>.broadcast();

  void Function(List<Message>?) get addResponse => _socketResponse.sink.add;
  void Function(List<Message>?) get sendMessage => _socketResponse.sink.add;

  Stream<List<Message>?> get getResponse => _socketResponse.stream;
  Stream<List<Message>?> get getMessage => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

class Api extends GetxService {
  final isProduction = const bool.fromEnvironment('dart.vm.product');
  var dio = createDio();
  static var storage = GetStorage();
  final token = storage.read(StorageKeys.token.name);
  var socket = createSocket();
  static Dio createDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: api,
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

  static IO.Socket createSocket() {
    IO.Socket socket =
        IO.io(url, IO.OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('connect');
    });

    try {
      socket.on(
          'message',
          (data) => {
            print(MessageTypes.TEXT)
                // if (data != null && data['messages'] != null)
                //   {
                //     streamSocket.addResponse((data['messages'] as List)
                //         .map((e) => Message.fromJson(e))
                //         .toList()),
                //   }
              });
    } catch (e) {
      print("error $e");
    }

    socket.onDisconnect((_) => print('disconnect'));
    return socket;
  }

  EitherResponse<String> login(User user) async {
    try {
      final data = {
        "email": user.email,
        "username": user.username,
        "profileImg": user.profileImg
      };

      final res = await dio.post('auth/login', data: data);

      if (res.statusCode == 201) {
        return right(ResponseModel(
            data: res.data['access_token'], message: res.data['message']));
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
      if (res.statusCode == 201) {
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
      if (res.statusCode == 200) {
        return right(User.fromJson(res.data));
      }

      return left("Нэвтрэнэ үү.");
    } catch (e) {
      return left(e.toString());
    }
  }
}
