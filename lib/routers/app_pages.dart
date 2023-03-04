import 'package:chat_firebase/home_page/views/home_screen.dart';
import 'package:chat_firebase/signUp_page/views/signUp_screen.dart';
import 'package:get/get.dart';

import '../home_page/bindings/home_binding.dart';
import '../logIn_page/bindings/logIn_binding.dart';
import '../logIn_page/views/login_screen.dart';
import '../signUp_page/bindings/signUp_binding.dart';

abstract class Routes {
  Routes._();

  static const LogIn = '/LogIn';
  static const SignUp = '/SignUp';
  static const home = '/Home';
}

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.LogIn,
      page: () => const LogInScreen(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: Routes.SignUp,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
