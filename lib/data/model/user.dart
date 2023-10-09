


class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
 

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phone,
     });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    
    return data;
  }
}
