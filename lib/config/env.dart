import 'package:dotenv_gen/dotenv_gen.dart';

part 'env.g.dart';

@DotEnvGen()
abstract class Env {

  const factory Env() = _$Env;

  const Env._();

  String get openWeatherApiURL;

  String get positionStackApiURL;

  String get positionStackApiKey;
}
