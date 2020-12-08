class SliderModel {
  String title;
  String icon;

  // "name": "Master's Kitchen", ""
  // "address": "Indian, Fast Food", "time": "30 mim", "rate": "4.8", "location": "2.5 km"

  SliderModel(this.title, this.icon);

  SliderModel.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    icon = json['icon'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.title;
    data['icon'] = this.icon;
    return data;
  }
}