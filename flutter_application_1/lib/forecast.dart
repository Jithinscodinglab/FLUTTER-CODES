import 'package:flutter/material.dart';
import 'package:flutter_application_1/apimethods.dart';
import 'package:flutter_application_1/weathermodelclass.dart';
import 'package:get/get.dart';

class ForecastView extends StatefulWidget {
  const ForecastView({super.key});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  var cityname;

  @override
  void initState() {
    super.initState();
    cityname = Get.arguments;
  }

  fromutctolocal(int unix) {
    var datetime = DateTime.fromMillisecondsSinceEpoch(unix * 1000, isUtc: true)
        .toLocal()
        .toString();
    return datetime;
  }

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuerySize;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              cityname.name,
              style: TextStyle(color: Colors.white, fontSize: size.height / 32),
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        body: FutureBuilder(
          future: WeatherService().getforecast(cityname.name),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ForecastWeatherModelClass> forecastlist = [];
              forecastlist = snapshot.data!;
              return SizedBox(
                height: size.height,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: forecastlist.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      leading: Icon(Icons.arrow_right, size: size.height / 30),
                      title: Text(
                          fromutctolocal(forecastlist[index].data!.first.dt!)
                              .toString()
                              .split(" ")[0],
                          style: TextStyle(
                              fontSize: size.height / 35, color: Colors.white)),
                      children: [
                        SizedBox(
                          height: size.height / 4,
                          width: size.width - 50,
                          child: Image.network(
                              fit: BoxFit.cover,
                              "https://openweathermap.org/img/wn/${forecastlist[index].data!.first.weather!.first.icon}@4x.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("🌡${forecastlist[index].data!.first.temp}°C",
                                style: TextStyle(
                                    fontSize: size.height / 40,
                                    color: Colors.white)),
                            Text(
                                "༄${forecastlist[index].data!.first.windSpeed} km / h",
                                style: TextStyle(
                                    fontSize: size.height / 42,
                                    color: Colors.white)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: size.height / 32,
                              ),
                              Text(
                                  "${forecastlist[index].data!.first.humidity} %",
                                  style: TextStyle(
                                      fontSize: size.height / 40,
                                      color: Colors.white)),
                            ]),
                            Text(
                                "☁️ ${forecastlist[index].data!.first.clouds} %",
                                style: TextStyle(
                                    fontSize: size.height / 42,
                                    color: Colors.white)),
                          ],
                        ),
                        Text(
                            forecastlist[index]
                                .data!
                                .first
                                .weather!
                                .first
                                .description!,
                            style: TextStyle(
                                fontSize: size.height / 32,
                                color: Colors.white))
                      ],
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
