import 'dart:async';
import 'dart:convert';

import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apimethods.dart';
import 'package:flutter_application_1/forecast.dart';
import 'package:flutter_application_1/weathermodelclass.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<City> citylist = [];
  var cityname = "Thrissur";
  City selectedcity = City(
      name: "Thrissur",
      countryCode: "IN",
      stateCode: "KL",
      latitude: "10.5256264",
      longitude: "76.2132542");

  List<City> switchablecitylist = [];

  @override
  void initState() {
    super.initState();
    getallcitieslist();
  }

  getallcitieslist() async {
    citylist = await getCountryCities("IN");
    citylist;
    getcities();
  }

  void getcities() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("citylist")) {
      List<String> list = prefs.getStringList("citylist")!;
      if (list.isNotEmpty) {
        for (var element in list) {
          var cityjson = jsonDecode(element);

          switchablecitylist.add(City.fromJson(cityjson));
        }
      }
    }
    if (switchablecitylist.isEmpty) {
      Timer(
        const Duration(seconds: 3),
        () {
          addcityweatherdialog();
        },
      );
    } else {
      setState(() {
        selectedcity = switchablecitylist[0];
        cityname = selectedcity.name;
      });
    }
  }

  addcityweatherdialog() {
    List<City>? sortedcitylist = [];
    return Get.defaultDialog(
      title: '',
      // titleStyle: const TextStyle(fontSize: ),
      content: StatefulBuilder(builder: (context, setstate) {
        var size = context.mediaQuerySize;
        return SizedBox(
          height: size.height / 1.6,
          width: size.width - 60,
          child: Column(
            children: [
              Text(
                "Add City",
                style: TextStyle(fontSize: size.height / 30),
              ),
              TextFormField(
                style: TextStyle(fontSize: size.height / 36),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "City name"),
                onChanged: (value) {
                  sortedcitylist = citylist.where(
                    (element) {
                      return element.name.isCaseInsensitiveContains(value);
                    },
                  ).toList();
                  setstate(() {
                    sortedcitylist;
                  });
                },
              ),
              SizedBox(
                height: size.height / 2.3,
                child: ListView.builder(
                  itemCount: sortedcitylist!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        selectedcity = sortedcitylist![index];
                        oncityselected(selectedcity);
                      },
                      title: Text(
                        sortedcitylist![index].name,
                        style: TextStyle(fontSize: size.height / 42),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void oncityselected(selectedcity) {
    switchablecitylist.add(selectedcity);
    switchablecitylist = switchablecitylist.toSet().toList();
    savetopreference(switchablecitylist);
    setState(() {});
    Navigator.pop(context);
  }

  fromutctolocal(int unix) {
    var datetime = DateTime.fromMillisecondsSinceEpoch(
      unix * 1000,
    ).toLocal().toString();
    return datetime;
  }

  savetopreference(List<City> selectedcitylist) async {
    List<String> list = List.generate(
      selectedcitylist.length,
      (index) {
        return jsonEncode(selectedcitylist[index]);
      },
    );
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("citylist", list);
  }

  void citychange() {
    if (switchablecitylist.length > 1 &&
        switchablecitylist.indexWhere(
              (element) => element.name == cityname,
            ) !=
            switchablecitylist.length - 1) {
      cityname = switchablecitylist[switchablecitylist.indexWhere(
                (element) => element.name == cityname,
              ) +
              1]
          .name;

      setState(() {});
    } else if (switchablecitylist.length > 1) {
      cityname = switchablecitylist[0].name;
      setState(() {});
    }
  }

  void swiperight() {}

  @override
  Widget build(BuildContext context) {
    var size = context.mediaQuerySize;

    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            switchablecitylist;
            cityname;
          });
        },
      ),
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addcityweatherdialog();
              },
              icon: Icon(
                Icons.add,
                size: size.height / 28,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.transparent,
        // title: Center(
        //   child: Text(
        //     'Weather',
        //     style: TextStyle(color: Colors.white, fontSize: size.height / 20),
        //   ),
        // ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              citychange();
            },
            child: Text(
              cityname,
              style: TextStyle(color: Colors.white, fontSize: size.height / 32),
            ),
          ),
          FutureBuilder(
              future: WeatherService().getWeather(
                  // lat: selectedcity.latitude,
                  // lon: selectedcity.latitude,
                  cityname: cityname),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  WeatherModelClass weatherModelClass = snapshot.data!;

                  return Center(
                      child: SizedBox(
                    height: size.height / 1.2,
                    width: size.width - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: size.height / 4,
                          width: size.width - 50,
                          child: Image.network(
                              fit: BoxFit.cover,
                              "https://openweathermap.org/img/wn/${weatherModelClass.current!.weather!.first.icon}@4x.png"),
                        ),
                        Card(
                          color: const Color.fromARGB(255, 66, 101, 119),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  weatherModelClass
                                      .current!.weather!.first.main!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.height / 32),
                                ),
                                weatherviewdesign(
                                    size,
                                    'Wind',
                                    "༄ ${weatherModelClass.current!.windSpeed!} km/h",
                                    'Visibility',
                                    "👁${weatherModelClass.current!.visibility!} hPa"),
                                weatherviewdesign(
                                  size,
                                  'Humidity',
                                  "💧${weatherModelClass.current!.humidity!}%",
                                  'Temp',
                                  "🌡${weatherModelClass.current!.temp!} °C",
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTile(
                                    childrenPadding: const EdgeInsets.all(10),
                                    title: Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.height / 36),
                                    ),
                                    children: [
                                      Text(
                                        weatherModelClass.alerts != null
                                            ? weatherModelClass
                                                .daily!.first.summary!
                                            : weatherModelClass.current!
                                                .weather!.first.description!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height / 40),
                                      )
                                    ],
                                  ),
                                ),
                                weatherviewdesign(
                                  size,
                                  'Feels like',
                                  "🌡${weatherModelClass.current!.feelsLike}°C",
                                  'Uvi',
                                  "☼${weatherModelClass.current!.uvi}",
                                )
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const ForecastView(),
                                arguments: selectedcity);
                          },
                          child: Text(
                            "5 - Day Weather Forecast",
                            style: TextStyle(fontSize: size.height / 32),
                          ),
                        )
                      ],
                    ),
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    ));
  }

  Row weatherviewdesign(Size size, String wind, String windspeed,
      String visibility, String visibilityvalue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              wind,
              style: TextStyle(fontSize: size.height / 45, color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  windspeed,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height / 32),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Text(
              visibility,
              style: TextStyle(fontSize: size.height / 45, color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  visibilityvalue,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height / 32),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
