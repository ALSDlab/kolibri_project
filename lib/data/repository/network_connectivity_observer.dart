import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_observer.dart';

class NetworkConnectivityObserver implements ConnectivityObserver {
  final _connectivity = Connectivity();

  @override
  Stream<Status> observe() {
    return _connectivity.onConnectivityChanged
        .map((results) {
      print('Connectivity changed: $results');
      // 어떤 연결이라도 있는지 확인
      final hasConnection = results.any((result) =>
      result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile);
      return hasConnection ? Status.available : Status.unavailable;
    })
        .handleError((error) {
      print('Connectivity error: $error');
      return Status.available;
    });
  }

}
