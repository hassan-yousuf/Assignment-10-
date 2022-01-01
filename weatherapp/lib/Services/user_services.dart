import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weatherapp/Models/user_models.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endPoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=10530cd042fdda8d65051ca864fc86bf');

    var response = await http.get(endPoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
