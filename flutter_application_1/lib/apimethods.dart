import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/weathermodelclass.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

var appidkey = "";

class WeatherService extends GetConnect {
  Future<WeatherModelClass> getWeather({lat, lon, cityname}) async {
    if (lat == null && lon == null) {
      LocationModelClass locationdata = await getlocation(cityname);
      lat = locationdata.lat;
      lon = locationdata.lon;
    }
    final weatherUrl = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=hourly&units=metric&appid=$appidkey');
    try {
      final response = await http.get(weatherUrl);
      if (response.statusCode == 200) {
        return WeatherModelClass.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to fetch weather data (Status Code: ${response.statusCode})');
      }
    } on Exception catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while fetching weather data: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<LocationModelClass> getlocation(cityname) async {
    final locationurl =
        "http://api.openweathermap.org/geo/1.0/direct?q=$cityname&limit=1&appid=$appidkey";
    final response = await get(locationurl);
    LocationModelClass locationdata = LocationModelClass();
    if (response.statusCode == 200) {
      locationdata = LocationModelClass.fromJson(response.body[0]);
    } else {
      throw Exception('Failed to fetch weather data');
    }
    return locationdata;
  }

  Future<List<ForecastWeatherModelClass>> getforecast(cityname) async {
    var currentdate = DateTime.now();
    List<ForecastWeatherModelClass> fivedaysforecastweatherdata = [];
    var datellist = List.generate(
      5,
      (index) {
        return currentdate
                .add(Duration(days: index + 1))
                .toUtc()
                .millisecondsSinceEpoch /
            1000;
      },
    );
    LocationModelClass locationdata = await getlocation(cityname);
    var lat = locationdata.lat;
    var lon = locationdata.lon;
    for (var date in datellist) {
      final forecasturl =
          "https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=$lat&lon=$lon&units=metric&dt=${date.toString().split(".")[0]}&appid=$appidkey";
      var response = await get(forecasturl);
      if (response.statusCode == 200) {
        fivedaysforecastweatherdata
            .add(ForecastWeatherModelClass.fromJson(response.body));
      }
    }
    return fivedaysforecastweatherdata;
  }
}
