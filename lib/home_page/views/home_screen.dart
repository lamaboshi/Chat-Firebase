import 'package:chat_firebase/global_widgets/chat_text_form_field.dart';
import 'package:chat_firebase/home_page/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../methods.dart';
import '../../routers/app_pages.dart';

class HomeScreen extends GetResponsiveView<HomeController> {
  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              logOut();
              Get.rootDelegate.toNamed(Routes.LogIn);
            },
          )
        ],
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            child: SizedBox(
              child: Obx(() => Column(
                  children: controller.messagell
                      .map((element) =>
                          element.email == controller.auth.currentUser!.email
                              ? messageSender(element.text!)
                              : messageText(element.text!))
                      .toList())),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Obx(() => ChatTextFormField(
                          'Write your message here.....',
                          defaultText: controller.text.value.isEmpty
                              ? null
                              : controller.text.value,
                          onChanged: (value) {
                            controller.text.value = value;
                          },
                        ))),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    controller.fireStore.collection('messages').add({
                      'sender': controller.auth.currentUser!.email!,
                      'text': controller.text.value
                    });
                    controller.text.value = '';
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ))
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget messageSender(String text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                text,
                style: const TextStyle(color: Colors.indigo),
              ),
            ),
            const SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              elevation: 10,
              color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            const SizedBox()
          ],
        ),
      ],
    );
  }

  Widget messageText(String text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                text,
                style: const TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              color: Colors.indigo.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.indigo, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
