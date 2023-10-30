class ResponseModel {
  String? message;
  dynamic data;

  ResponseModel({
    this.data,
    this.message,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
