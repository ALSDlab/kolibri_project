import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', obfuscate: true, useConstantCase: true)
abstract class Env {
  // Node.js Server IP Address
  @EnviedField()
  static String kolibriServerAddress = _Env.kolibriServerAddress;
}