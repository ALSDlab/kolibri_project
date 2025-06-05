abstract class ConnectivityObserver {
  //네트워크가 사용가능한지 아닌지
  Stream<Status> observe();
}

enum Status {
  available,
  unavailable,
}