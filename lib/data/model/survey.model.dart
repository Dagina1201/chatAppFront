class Survey {
  String? sId;
  String? type;
  String? created;
  String? createdAt;
  String? updatedAt;
  Content? content;
  String? title;
  List<Values>? values;

  Survey(
      {this.sId,
      this.type,
      this.created,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.title,
      this.values});

  Survey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    created = json['created'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    title = json['title'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['created'] = this.created;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['title'] = this.title;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? type;
  String? content;

  Content({this.type, this.content});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['content'] = this.content;
    return data;
  }
}

class Values {
  String? type;
  int? id;
  bool? required;
  List<Content>? list;
  String? question;

  Values({this.type, this.id, this.required, this.list, this.question});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    required = json['required'];
    if (json['list'] != null) {
      list = <Content>[];
      json['list'].forEach((v) {
        list!.add(new Content.fromJson(v));
      });
    }
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['required'] = this.required;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['question'] = this.question;
    return data;
  }
}
