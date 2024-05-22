class WeatherModelClass {
  double? lat;
  double? lon;
  String? timezone;
  double? timezoneOffset;
  Current? current;
  List<Hourly>? hourly;
  List<Daily>? daily;
  List<Alerts>? alerts;

  WeatherModelClass(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.hourly,
      this.daily,
      this.alerts});

  WeatherModelClass.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] is int ? json['lat'].toDouble() : json['lat'];
    lon = json['lon'] is int ? json['lon'].toDouble() : json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'] is int
        ? json['timezone_offset'].toDouble()
        : json['timezone_offset'];
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(Daily.fromJson(v));
      });
    }
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add(Alerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly!.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      data['daily'] = daily!.map((v) => v.toJson()).toList();
    }
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  int? dt;
  double? sunrise;
  double? sunset;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? uvi;
  double? clouds;
  double? visibility;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;

  Current(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather});

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] ;
    sunrise =
        json['sunrise'] is int ? json['sunrise'].toDouble() : json['sunrise'];
    sunset = json['sunset'] is int ? json['sunset'].toDouble() : json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'] is int
        ? json['pressure'].toDouble()
        : json['pressure'];
    humidity = json['humidity'] is int
        ? json['humidity'].toDouble()
        : json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'] is int ? json['uvi'].toDouble() : json['uvi'];
    clouds = json['clouds'] is int ? json['clouds'].toDouble() : json['clouds'];
    visibility = json['visibility'] is int
        ? json['visibility'].toDouble()
        : json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'] is int
        ? json['wind_deg'].toDouble()
        : json['wind_deg'];
    windGust = json['wind_gust'] is int
        ? json['wind_gust'].toDouble()
        : json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Hourly {
  double? dt;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? uvi;
  double? clouds;
  double? visibility;
  double? windSpeed;
  double? windDeg;
  double? windGustis;
  double? windGust;
  List<Weather>? weather;
  double? pop;

  Hourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.pop});

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] is int ? json['dt'].toDouble() : json['dt'];
    temp = json['temp'] is int ? json['temp'].toDouble() : json['temp'];
    feelsLike = json['feels_like'] is int
        ? json['feels_like'].toDouble()
        : json['feels_like'];
    pressure = json['pressure'] is int
        ? json['pressure'].toDouble()
        : json['pressure'];
    humidity = json['humidity'] is int
        ? json['humidity'].toDouble()
        : json['humidity'];
    dewPoint = json['dew_point'] is int
        ? json['dew_point'].toDouble()
        : json['dew_point'];
    uvi = json['uvi'] is int ? json['uvi'].toDouble() : json['uvi'];
    clouds = json['clouds'] is int ? json['clouds'].toDouble() : json['clouds'];
    visibility = json['visibility'] is int
        ? json['visibility'].toDouble()
        : json['visibility'];
    windSpeed = json['wind_speed'] is int
        ? json['wind_speed'].toDouble()
        : json['wind_speed'];
    windDeg = json['wind_deg'] is int
        ? json['wind_deg'].toDouble()
        : json['wind_deg'];
    windGust = json['wind_gust'] is int
        ? json['wind_gust'].toDouble()
        : json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    pop = json['pop'] is int ? json['pop'].toDouble() : json['pop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['pop'] = pop;
    return data;
  }
}

class Daily {
  double? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  String? summary;
  Temp? temp;
  FeelsLike? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? clouds;
  double? pop;
  double? uvi;

  Daily(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.summary,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.uvi});

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] is int ? json['dt'].toDouble() : json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'] is int
        ? json['moon_phase'].toDouble()
        : json['moon_phase'];
    summary = json['summary'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'] is int
        ? json['pressure'].toDouble()
        : json['pressure'];
    humidity = json['humidity'] is int
        ? json['humidity'].toDouble()
        : json['humidity'];
    dewPoint = json['dew_point'] is int
        ? json['dew_point'].toDouble()
        : json['dew_point'];
    windSpeed = json['wind_speed'] is int
        ? json['wind_speed'].toDouble()
        : json['wind_speed'];
    windDeg = json['wind_deg'] is int
        ? json['wind_deg'].toDouble()
        : json['wind_deg'];
    windGust = json['wind_gust'] is int
        ? json['wind_gust'].toDouble()
        : json['wind_gust'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'] is int ? json['clouds'].toDouble() : json['clouds'];
    pop = json['pop'] is int ? json['pop'].toDouble() : json['pop'];
    uvi = json['uvi'] is int ? json['uvi'].toDouble() : json['uvi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    data['summary'] = summary;
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    if (feelsLike != null) {
      data['feels_like'] = feelsLike!.toJson();
    }
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['uvi'] = uvi;
    return data;
  }
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'] is int ? json['day'].toDouble() : json['day'];
    min = json['min'] is int ? json['min'].toDouble() : json['min'];
    max = json['max'] is int ? json['max'].toDouble() : json['max'];
    night = json['night'] is int ? json['night'].toDouble() : json['night'];
    eve = json['eve'] is int ? json['eve'].toDouble() : json['eve'];
    morn = json['morn'] is int ? json['morn'].toDouble() : json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'] is int ? json['day'].toDouble() : json['day'];
    night = json['night'] is int ? json['night'].toDouble() : json['night'];
    eve = json['eve'] is int ? json['eve'].toDouble() : json['eve'];
    morn = json['morn'] is int ? json['morn'].toDouble() : json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class Alerts {
  String? senderName;
  String? event;
  int? start;
  int? end;
  String? description;
  List<String>? tags;

  Alerts(
      {this.senderName,
      this.event,
      this.start,
      this.end,
      this.description,
      this.tags});

  Alerts.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    event = json['event'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['event'] = event;
    data['start'] = start;
    data['end'] = end;
    data['description'] = description;
    data['tags'] = tags;
    return data;
  }
}

class LocationModelClass {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  LocationModelClass({this.name, this.lat, this.lon, this.country, this.state});

  LocationModelClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'] is int ? json['lat'].todouble() : json['lat'];
    lon = json['lon'] is int ? json['lon'].todouble() : json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;

    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class ForecastWeatherModelClass {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  List<Current>? data;

  ForecastWeatherModelClass(
      {this.lat, this.lon, this.timezone, this.timezoneOffset, this.data});

  ForecastWeatherModelClass.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    if (json['data'] != null) {
      data = <Current>[];
      json['data'].forEach((v) {
        data!.add(Current.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Data {
//   int? dt;
//   int? sunrise;
//   int? sunset;
//   double? temp;
//   double? feelsLike;
//   double? pressure;
//   double? humidity;
//   double? dewPoint;
//   double? uvi;
//   double? clouds;
//   double? visibility;
//   double? windSpeed;
//   double? windDeg;
//   double? windGust;
//   List<Weather>? weather;

//   Data(
//       {this.dt,
//       this.sunrise,
//       this.sunset,
//       this.temp,
//       this.feelsLike,
//       this.pressure,
//       this.humidity,
//       this.dewPoint,
//       this.uvi,
//       this.clouds,
//       this.visibility,
//       this.windSpeed,
//       this.windDeg,
//       this.windGust,
//       this.weather});

//   Data.fromJson(Map<String, dynamic> json) {
//     dt = json['dt'];
//     sunrise = json['sunrise'];
//     sunset = json['sunset'];
//     temp = json['temp'];
//     feelsLike = json['feels_like'];
//     pressure = json['pressure'];
//     humidity = json['humidity'];
//     dewPoint = json['dew_point'];
//     uvi = json['uvi'];
//     clouds = json['clouds'];
//     visibility = json['visibility'];
//     windSpeed = json['wind_speed'];
//     windDeg = json['wind_deg'];
//     windGust = json['wind_gust'];
//     if (json['weather'] != null) {
//       weather = <Weather>[];
//       json['weather'].forEach((v) {
//         weather!.add(Weather.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['dt'] = dt;
//     data['sunrise'] = sunrise;
//     data['sunset'] = sunset;
//     data['temp'] = temp;
//     data['feels_like'] = feelsLike;
//     data['pressure'] = pressure;
//     data['humidity'] = humidity;
//     data['dew_point'] = dewPoint;
//     data['uvi'] = uvi;
//     data['clouds'] = clouds;
//     data['visibility'] = visibility;
//     data['wind_speed'] = windSpeed;
//     data['wind_deg'] = windDeg;
//     data['wind_gust'] = windGust;
//     if (weather != null) {
//       data['weather'] = weather!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
