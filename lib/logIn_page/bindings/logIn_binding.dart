import 'package:get/get.dart';

import '../controllers/logIn_controller.dart';

class LogInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LogInController());
  }
}
