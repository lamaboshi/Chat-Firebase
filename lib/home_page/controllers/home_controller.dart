import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/message.dart';

class HomeController extends GetxController {
  final text = ''.obs;
  late User signdInUser;
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final messagell = <Message>[].obs;
  @override
  void onInit() {
    super.onInit();
    getMessages();
  }

  Future<void> getMessages() async {
    await for (var snapshot in fireStore.collection('messages').snapshots()) {
      for (var element in snapshot.docs) {
        if (!messagell.any((p0) =>
            p0.email == element.get('sender') &&
            p0.text == element.get('text'))) {
          messagell.add(
              Message(email: element.get('sender'), text: element.get('text')));
        }
      }
    }
  }
}
