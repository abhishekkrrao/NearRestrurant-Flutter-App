class SliderModel {
  String title;
  String icon;
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