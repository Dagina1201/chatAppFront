import 'package:front/data/data.dart';

class Chat {
  String? types;
  String? name;
  String? nickname;
  int? number;
  Message? pin;
  User? teacher;
  User? created;
  List<User>? users;
  int? groupNumber;
  String? img;

  Chat(
      {this.types,
      this.name,
      this.groupNumber,
      this.nickname,
      this.number,
      this.pin,
      this.teacher,
      this.created,
      this.img,
      this.users});

  Chat.fromJson(Map<String, dynamic> json) {
    types = json['types'];
    name = json['name'];
    nickname = json['nickname'];
    number = json['number'];
    groupNumber = json['groupNumber'];
    img = json['img'];
    pin = json['pin'] != null ? new Message.fromJson(json['pin']) : null;
    teacher =
        json['teacher'] != null ? new User.fromJson(json['teacher']) : null;
    created =
        json['created'] != null ? new User.fromJson(json['created']) : null;
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['types'] = this.types;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['number'] = this.number;
    data['img'] = this.img;
    data['groupNumber'] = this.groupNumber;
    if (this.pin != null) {
      data['pin'] = this.pin!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.created != null) {
      data['created'] = this.created!.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pin {
  String? messageType;

  Pin({this.messageType});

  Pin.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageType'] = this.messageType;
    return data;
  }
}

class Teacher {
  String? nickname;

  Teacher({this.nickname});

  Teacher.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    return data;
  }
}