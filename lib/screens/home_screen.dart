import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherworks/controller/global_controller.dart';
import 'package:weatherworks/utils/custom_colors.dart';
import 'package:weatherworks/widgets/comfort_level.dart';
import 'package:weatherworks/widgets/current_weather_widget.dart';
import 'package:weatherworks/widgets/daily_data_forcast.dart';
import 'package:weatherworks/widgets/header_widget.dart';
import 'package:weatherworks/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clouds.png",
                        height: 200,
                        width: 200,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                )
              // const Center(
              //     child: CircularProgressIndicator(),
              //   )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const HeaderWidget(),
                      // for our current temp ('current')
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),
                      DailyDataForcast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevel(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
