class RestModel {
  String title;
  String icon;
  String address;
  String time;
  String rate;
  String location;
  String price;
  RestModel(this.title, this.icon,this.time,this.price,this.location,this.rate);
  RestModel.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    icon = json['icon'];
    address = json['address'];
    time = json['time'];
    rate = json['rate'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    data['icon'] = this.icon;
    data['address'] = this.address;
    data['time'] = this.time;
    data['rate'] = this.rate;
    data['price'] = this.price;
    return data;
  }
}