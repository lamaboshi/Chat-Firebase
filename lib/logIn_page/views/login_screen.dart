import 'package:chat_firebase/logIn_page/controllers/logIn_controller.dart';
import 'package:chat_firebase/routers/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/chat_text_form_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<LogInController>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.indigo,
            height: size.height,
            width: size.width,
          ),
          Positioned(
            top: -30,
            right: -40,
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: SizedBox(
                height: size.height,
                child: Column(children: [
                  SizedBox(
                    height: size.height / 10,
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  SizedBox(
                    width: size.width / 1.3,
                    child: const Text('Welcome',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: size.width / 1.3,
                    child: const Text(
                      'Sign In to contiue!',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        Container(
                            width: size.width - 60,
                            alignment: Alignment.center,
                            child: ChatTextFormField(
                              'email',
                              prefixIcon: Icons.account_box,
                              onChanged: (value) {
                                controller.email.value = value;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            child: Container(
                              width: size.width - 60,
                              alignment: Alignment.center,
                              child: ChatTextFormField(
                                'password',
                                prefixIcon: Icons.lock,
                                onChanged: (value) {
                                  controller.password.value = value;
                                },
                              ),
                            )),
                        SizedBox(
                          height: size.height / 6,
                        ),
                        Obx(() => controller.isloading.value
                            ? const CircularProgressIndicator(
                                color: Colors.indigo,
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  controller.logInFun();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 7,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'LogIn',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Have Account?',
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.rootDelegate.toNamed(Routes.SignUp);
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.6)),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
