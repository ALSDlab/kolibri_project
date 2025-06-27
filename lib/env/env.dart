import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', obfuscate: true, useConstantCase: true)
abstract class Env {
  // .env 파일에서 웹 서버 주소를 읽어옵니다.
  @EnviedField(varName: 'KOLIBRI_SERVER_ADDRESS')
  static final String _kolibriServerAddress = _Env._kolibriServerAddress;

  static String get kolibriServerAddress {
    return _kolibriServerAddress;
  }
}