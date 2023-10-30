class User {
  String? sId;
  String? email;
  String? username;
  String? phone;
  String? nickname;
  String? profileImg;

  User({
    this.sId,
    this.email,
    this.username,
    this.phone,
    this.nickname,
    this.profileImg,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    nickname = json['nickname'];
    profileImg = json['profileImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    data['nickname'] = nickname;
    data['profileImg'] = profileImg;

    return data;
  }
}
