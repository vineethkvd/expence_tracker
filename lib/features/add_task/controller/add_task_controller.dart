import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expence_tracker/features/home/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../model/view_task_model.dart';

class AddTaskController extends GetxController {
  var isLoading = false.obs;
  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> taskName = TextEditingController().obs;
  final Rx<TextEditingController> taskDescription = TextEditingController().obs;
  final Rx<TextEditingController> taskStartDate = TextEditingController().obs;
  final Rx<TextEditingController> taskEndDate = TextEditingController().obs;
  final Rx<TextEditingController> document = TextEditingController().obs;
  final Rx<TextEditingController> amount = TextEditingController().obs;
  var downloadUrl = ''.obs;

  Future<String?> openCalendar({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      return formattedDate;
    } else {
      print("failed");
    }
    return null;
  }

  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(source: source);
    if (imageFile != null) {
      return File(imageFile.path);
    }
    return null;
  }

  Future<String?> uploadImage(String image) async {
    try {
      String fileName =
          'task_document/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(fileName).putFile(File(image));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      showToastMsg('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> addTask() async {
    try {
      isLoading.value = true;
      CollectionReference taskCollection =
          FirebaseFirestore.instance.collection('task');

      // Generate a unique document reference with a unique ID
      DocumentReference taskDoc = taskCollection.doc();

      downloadUrl.value = (await uploadImage(document.value.text))!;
      await taskDoc.set({
        'id': taskDoc.id, // Add the unique ID to the task data
        'taskName': taskName.value.text,
        'taskDescription': taskDescription.value.text,
        'taskStartDate': taskStartDate.value.text,
        'taskEndDate': taskEndDate.value.text,
        'document': downloadUrl.value,
        'amount': amount.value.text
      });

      showToastMsg('Task added successfully');
      Get.to(const HomePage(), transition: Transition.cupertino);
    } catch (e) {
      showToastMsg('Failed to add task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    taskEndDate.value.clear();
    taskStartDate.value.clear();
    taskDescription.value.clear();
    taskName.value.clear();
    document.value.clear();
  }

  Future<bool?> showToastMsg(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #000000, #434343)",
      webPosition: "bottom",
    );
  }

  Future<List<ViewTaskModel>> fetchAllTasks() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('task').get();

      return querySnapshot.docs
          .map((doc) =>
              ViewTaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      showToastMsg('Failed to fetch tasks: $e');
      return [];
    }
  }
}
