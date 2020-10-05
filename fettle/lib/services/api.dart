class Api {
  // static String api = 'http://192.168.1.118:8080/api/';
  // static String api = 'http://192.168.1.7:8080/api/';

  static String api = 'https://altlifeapi.appspot.com/api/';
  // static String api = 'http://localhost:8080/api/';
  // static String api = 'http://192.168.1.135:8080/api/';

  static String apiCall(String endpoint) {
    return api + endpoint;
  }
}
