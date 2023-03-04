import 'package:chat_firebase/signUp_page/controllers/signUp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/chat_text_form_field.dart';
import '../../methods.dart';
import '../../routers/app_pages.dart';

class SignUpScreen extends GetResponsiveView<SignUpController> {
  @override
  Widget builder() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.indigo,
            height: screen.height,
            width: screen.width,
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
                height: screen.height,
                child: Column(children: [
                  SizedBox(
                    height: screen.height / 10,
                  ),
                  SizedBox(
                    height: screen.height / 50,
                  ),
                  SizedBox(
                    width: screen.width / 1.3,
                    child: const Text('Welcome',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: screen.width / 1.3,
                    child: const Text(
                      'Sign Up to contiue!',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: screen.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        Container(
                            width: screen.width - 60,
                            alignment: Alignment.center,
                            child: ChatTextFormField(
                              'name',
                              prefixIcon: Icons.person,
                              onChanged: (value) {
                                controller.name.value = value;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            child: Container(
                              width: screen.width - 60,
                              alignment: Alignment.center,
                              child: ChatTextFormField(
                                'email',
                                prefixIcon: Icons.account_box,
                                onChanged: (value) {
                                  controller.email.value = value;
                                },
                              ),
                            )),
                        Container(
                          width: screen.width - 60,
                          alignment: Alignment.center,
                          child: ChatTextFormField(
                            'password',
                            prefixIcon: Icons.lock,
                            onChanged: (value) {
                              controller.password.value = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: screen.height / 6,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await createAccount(
                                controller.name.value,
                                controller.email.value,
                                controller.password.value);
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
                              'Create Account',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
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
                                    'LogIn',
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
