class Diagram {
  double? value;
  double? active;
  String? name;

  Diagram({this.value, this.active, this.name});

  Diagram.fromJson(Map<String, dynamic> json) {
    value = double.parse(json['value']);
    active = double.parse(json['active']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['active'] = this.active;
    data['name'] = this.name;
    return data;
  }
}