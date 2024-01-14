import 'package:front/data/data.dart';

class Chat {
  String? sId;
  String? types;
  String? name;
  String? nickname;
  int? number;
  String? pin;
  String? teacher;
  String? created;
  List<String>? users;
  int? groupNumber;
  String? img;

  Chat(
      {this.types,
      this.name,
      this.sId,
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
    sId = json['_id'];
    name = json['name'];
    nickname = json['nickname'];
    number = json['number'];
    groupNumber = json['groupNumber'];
    img = json['img'];
    pin = json['pin'];
    teacher = json['teacher'];
    created = json['created'];
    if (json['users'] != null) {
      users = <String>[];
      json['users'].forEach((v) {
        users!.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['types'] = this.types;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['number'] = this.number;
    data['img'] = this.img;
    data['groupNumber'] = this.groupNumber;
    if (this.pin != null) {
      data['pin'] = this.pin;
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher;
    }
    if (this.created != null) {
      data['created'] = this.created;
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toString()).toList();
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
