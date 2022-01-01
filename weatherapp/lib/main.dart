import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/Models/user_models.dart';
import 'package:weatherapp/Services/user_services.dart';
import 'package:weatherapp/views/additional_information.dart';
import 'package:weatherapp/views/current_weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client.getCurrentWeather('Georgia');
  }

  Future<void> getData() async {
    data = await client.getCurrentWeather('Karachi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFFf9f9f9),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Fluttertoast.showToast(msg: 'Menu Touched');
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, '${data!.temp}',
                    '${data!.cityName}'),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  'Additional Information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Color(0xdd212121)),
                ),
                Divider(),
                SizedBox(
                  height: 20.0,
                ),
                additionalInformation('${data!.wind}', '${data!.humidity}',
                    '${data!.pressure}', '${data!.feels_like}')
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
