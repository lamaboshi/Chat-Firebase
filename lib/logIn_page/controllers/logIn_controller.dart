import 'package:get/get.dart';

import '../../methods.dart';
import '../../routers/app_pages.dart';

class LogInController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isloading = false.obs;
  Future<void> logInFun() async {
    isloading.value = true;
    var result = await logIn(email.value, password.value);
    if (result != null) {
      isloading.value = false;
      Get.rootDelegate.toNamed(Routes.home);
    }

    isloading.value = false;
  }
}
