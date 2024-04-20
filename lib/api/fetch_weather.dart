import 'dart:convert';
import 'package:weatherworks/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherworks/model/weather_data_current.dart';
import 'package:weatherworks/model/weather_data_daily.dart';
import 'package:weatherworks/model/weather_data_hourly.dart';
import 'package:weatherworks/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing the data from response -> to json
  Future<WeatherData> processData(latitude, longitude) async {
    var response = await http.get(Uri.parse(apiURL(latitude, longitude)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));
    return weatherData!;
  }
}
