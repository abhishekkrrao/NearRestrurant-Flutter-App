import 'dart:convert';
import 'package:eshop/src/model/RestModel.dart';
import 'package:eshop/src/model/Slider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Services {
  static Future<List<RestModel>> getJson() async {
    try {
      final response = await rootBundle.loadString('assets/local.json');
      List<RestModel> list = parseData(response);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<SliderModel>> getSliderJson() async {
    try {
      final response = await rootBundle.loadString('assets/slider.json');
      List<SliderModel> list = parseSliderData(response);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  static getNSliderJson() async  {
    try {
      String response = await rootBundle.loadString('assets/slider.json');
      Map<String, dynamic> list = json.decode(response.toString());
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static List<SliderModel> parseSliderData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
  }
  static List<RestModel> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RestModel>((json) => RestModel.fromJson(json)).toList();
  }
}
