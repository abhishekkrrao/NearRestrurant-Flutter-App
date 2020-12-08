class RestModel {
  String title;
  String icon;
  String address;
  // "name": "Master's Kitchen", ""
  // "address": "Indian, Fast Food", "time": "30 mim", "rate": "4.8", "location": "2.5 km"

  RestModel(this.title, this.icon, this.address);

  RestModel.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    icon = json['icon'];
    address = json['address'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    data['icon'] = this.icon;
    data['address'] = this.address;
    return data;
  }
}