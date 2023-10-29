


class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
  String? nickname;
  String? uri;
 

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phone,
      this.nickname,
      this.uri,
     });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    nickname = json['nickname'];
    uri = json['uri'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['nickname'] = nickname;
    data['uri'] = uri;
    
    return data;
  }
}
