import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:front/data/data.dart';
import 'package:front/data/model/user.dart';
import 'package:front/global/global.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:developer' as dev;

typedef EitherUser<T> = Future<Either<String, User>>;
typedef EitherChats<T> = Future<Either<String, List<Chat>>>;
typedef EitherChat<T> = Future<Either<String, Chat>>;
// typedef EitherChatUsers<T> = Future<Either<String, Tuple2<Chat, List<User>>>>;
typedef EitherUsers<T> = Future<Either<String, List<User>>>;
typedef EitherResponse<T> = Future<Either<String, ResponseModel>>;
typedef EitherText<T> = Future<Either<String, String>>;

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
      dev.log('connected');
    });

    try {
      socket.on(
          'message',
          (data) => {
                if (data != null && data['messages'] != null)
                  {
                    streamSocket.addResponse((data['messages'] as List)
                        .map((e) => Message.fromJson(e))
                        .toList()),
                  }
              });
    } catch (e) {
      dev.log(e.toString());
    }

    socket.onDisconnect((_) => print('disconnect'));
    return socket;
  }

  // auth

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
      dev.log(e.toString());
      return left(Messages.occured);
    }
  }

  EitherText<String> register(
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
      dev.log(e.toString());
      return left(Messages.occured);
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
      dev.log(e.toString());
      return left(Messages.occured);
    }
  }

  // chat
  EitherChats<List<Chat>> getChats(ChatTypes type) async {
    try {
      final res = await dio.get('/chat/me/${type.name}');

      if (res.statusCode == 200) {
        return right((res.data as List).map((e) => Chat.fromJson(e)).toList());
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherChat<Chat> getChatById(String id) async {
    try {
      final res = await dio.get('/chat/get/$id');

      if (res.statusCode == 200) {
        return right(Chat.fromJson(res.data));
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherUsers<List<User>> getChatUsers(String chat) async {
    try {
      final res = await dio.get('/chat/users/$chat');

      if (res.statusCode == 200) {
        return right((res.data as List).map((e) => User.fromJson(e)).toList());
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherSuccess<bool> createChat(
      ChatTypes type, String chat, List<String> users) async {
    try {
      final body = {
        "types": type.name,
        "chat": chat,
        "users": users,
      };
      final res = await dio.post('/chat', data: body);

      if (res.statusCode == 201) {
        return right(true);
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherSuccess<bool> joinChat(String id) async {
    try {
      final res = await dio.get('/chat/join/$id');

      if (res.statusCode == 200) {
        return right(true);
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherChats<List<Chat>> search(ChatTypes type, String value) async {
    try {
      final res = await dio.get('/chat/search/${type.name}/$value');

      if (res.statusCode == 200) {
        return right((res.data as List).map((e) => Chat.fromJson(e)).toList());
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }

  EitherUsers<List<User>> searchUsers(UserTypes type, String value) async {
    try {
      final res = await dio.get('/user/search/${type.name}/$value');

      if (res.statusCode == 200) {
        return right((res.data as List).map((e) => User.fromJson(e)).toList());
      }

      return left(Messages.occured);
    } catch (e) {
      dev.log(e.toString());

      return left(Messages.occured);
    }
  }
}
