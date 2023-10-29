import 'package:front/data/data.dart';
import 'package:front/global/global.dart';

class Message {
  MessageTypes? messageType;
  String? content;
  String? chat;
  User? sender;
  List<Reactions>? reactions;
  List<UsersReaction>? usersReaction;

  Message(
      {this.messageType,
      this.content,
      this.chat,
      this.sender,
      this.reactions,
      this.usersReaction});

  Message.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    content = json['content'];
    chat = json['chat'];
    sender =
        json['sender'] != null ? new User.fromJson(json['sender']) : null;
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(new Reactions.fromJson(v));
      });
    }
    if (json['usersReaction'] != null) {
      usersReaction = <UsersReaction>[];
      json['usersReaction'].forEach((v) {
        usersReaction!.add(new UsersReaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageType'] = this.messageType;
    data['content'] = this.content;
    data['chat'] = this.chat;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
    }
    if (this.usersReaction != null) {
      data['usersReaction'] =
          this.usersReaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sender {
  String? reaction;

  Sender({this.reaction});

  Sender.fromJson(Map<String, dynamic> json) {
    reaction = json['reaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reaction'] = this.reaction;
    return data;
  }
}

class Reactions {
  String? reaction;
  int? quantity;

  Reactions({this.reaction, this.quantity});

  Reactions.fromJson(Map<String, dynamic> json) {
    reaction = json['reaction'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reaction'] = this.reaction;
    data['quantity'] = this.quantity;
    return data;
  }
}

class UsersReaction {
  User? user;
  String? reaction;

  UsersReaction({this.user, this.reaction});

  UsersReaction.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reaction = json['reaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['reaction'] = this.reaction;
    return data;
  }
}
