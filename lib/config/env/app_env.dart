import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  final String openWeatherApiURL = dotenv.get('OPEN_WEATHER_API_URL');
  final String positionStackApiURL = dotenv.get('POSITION_STACK_API_URL');
  final String positionStackApiKey = dotenv.get('POSITION_STACK_API_KEY');
}
