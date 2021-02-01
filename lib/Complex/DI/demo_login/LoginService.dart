import 'package:flutter_app/Complex/DI/demo_login/Api.dart';

class LoginService {
  Api api;
  // Inject the api through the constructor
  LoginService(this.api);
}