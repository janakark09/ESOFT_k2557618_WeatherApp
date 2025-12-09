import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../weather/weather_screen.dart';
import '../weather/weather_provider.dart';
import '../other/about_dev_screen.dart';
/*============================== Home Screen for default Weather Dashboard =====================================*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherProvider weatherProvider;
  // ================================ Declare "Colombo" as Home City ====================================
  final homeCity="Colombo";
  //=====================================================================================================

  //-----------------------------------Initial state----------------------------------------
  @override
  void initState() {
    super.initState();
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);       // listen: false - this widget will NOT rebuild when the provider notifies listeners
    weatherProvider.getWeather(homeCity);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Color.fromRGBO(129, 129, 129, 1),
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child:SingleChildScrollView(      // for Scroll view in the Screen ------------------------
          child: Column(
            children: [
              //========================================= animated image for Home Screen =========================================
              //image section
              Image.asset('assets/images/anim_icon.gif',
                fit:BoxFit.scaleDown,
                height: 200,
              ),

              SizedBox(height: 15),
              //========================================== Welcome text ==========================================
              //text.section
              Text("Welcome",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),

              Text("To Weather App",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),
//=========================================  Weather result for Home city using Consumer ==============================================
              Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (provider.weather != null) {
                    final weather = provider.weather!;
                    return SizedBox(
                      width: w,
                      child: Column(
                        children: [
                          //------------------------------ City Name ----------------------
                          Text(
                            weather.cityName,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          //------------------------------ Temperature ----------------------
                          Text(
                            "${weather.temp}°C",
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 10),
                          //------------------------------ weather description ----------------------
                          Text(
                            weather.description,
                            style: const TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                          //------------------------------ weather icon using openweathermap.org network image ----------------------
                          Image.network(
                            "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                          ),
                        ],
                      ),
                    );
                  }
                  else {
                    return const Text("Loading Error of weather");
                  }
                },
              ),
              const SizedBox(height: 20),
//===============================================Search button for Location Weather Screen ===============================================================
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor:Colors.black,
                    minimumSize: Size(200, 50)
                ),
                onPressed: ()
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WeatherScreen()));
                },
                child: const Text("Search By Location",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
//================================================== Button for about developer screen =============================================================
              TextButton(onPressed: ()  async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutdevScreen()));
              },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black54,
                ),
                child: const Text("About Developer"),

              ),
            ],
          ),
        ),

      ),
    );
  }
}
