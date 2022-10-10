import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  final String positionStackApiKey = dotenv.get('POSITION_STACK_API_KEY');
}