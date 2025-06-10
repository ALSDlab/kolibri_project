import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'env.g.dart';

@Envied(path: 'lib/env/.env', obfuscate: true, useConstantCase: true)
abstract class Env {
  // .env 파일에서 웹 서버 주소를 읽어옵니다.
  @EnviedField(varName: 'KOLIBRI_SERVER_ADDRESS_WEB')
  static final String _kolibriServerAddressWeb = _Env._kolibriServerAddressWeb;

  // .env 파일에서 모바일 서버 주소를 읽어옵니다.
  @EnviedField(varName: 'KOLIBRI_SERVER_ADDRESS_MOBILE')
  static final String _kolibriServerAddressMobile = _Env._kolibriServerAddressMobile;

  /// 현재 플랫폼(Web/Mobile)에 맞는 서버 주소를 반환하는 getter.
  /// 앱의 다른 부분에서는 이 getter를 통해 주소를 사용합니다.
  static String get kolibriServerAddress {
    return kIsWeb ? _kolibriServerAddressWeb : _kolibriServerAddressMobile;
  }
}