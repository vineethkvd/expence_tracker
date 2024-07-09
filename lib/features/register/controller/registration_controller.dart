import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../login/view/login_page.dart';

class RegistrationController extends GetxController {
  var dropdownValuesGender = ['Male', 'Female', 'Others'];
  var deviceToken = ''.obs;
  var passwordVisible = true.obs;
  var isLoading = false.obs;

  void updateVisibility() {
    passwordVisible.toggle();
    update();
  }

  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;
  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> email = TextEditingController().obs;
  final Rx<TextEditingController> phone = TextEditingController().obs;
  final Rx<TextEditingController> gender = TextEditingController().obs;
  final Rx<TextEditingController> dob = TextEditingController().obs;
  final Rx<TextEditingController> password = TextEditingController().obs;
  final Rx<TextEditingController> photo = TextEditingController().obs;
  var downloadUrl = ''.obs;

  Future<void> openCalendar({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      dob.value.text = formattedDate;
    } else {
      print("failed");
    }
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
          'profile_pics/${DateTime.now().millisecondsSinceEpoch}.jpg';
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

  Future<void> getDeviceToken() async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        deviceToken.value = token;
      }
    } catch (e) {
      showToastMsg('Failed to get device token: $e');
    }
  }

  Future<void> userRegistration() async {
    try {
      isLoading.value = true;
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Generate a unique document reference with a unique ID
      DocumentReference userDoc = users.doc();

      // Check if email or phone already exists
      QuerySnapshot emailQuery =
      await users.where('email', isEqualTo: email.value.text).get();
      QuerySnapshot phoneQuery =
      await users.where('phone', isEqualTo: phone.value.text).get();

      if (emailQuery.docs.isNotEmpty) {
        showToastMsg('Email already exists');
        return;
      }

      if (phoneQuery.docs.isNotEmpty) {
        showToastMsg('Phone number already exists');
        return;
      }

      await getDeviceToken();

      if (photo.value.text.isNotEmpty) {
        downloadUrl.value = (await uploadImage(photo.value.text))!;
      } else {
        showToastMsg('Image is empty');
        return;
      }

      await userDoc.set({
        'name': name.value.text,
        'email': email.value.text,
        'phone': phone.value.text,
        'gender': gender.value.text,
        'dob': dob.value.text,
        'password': password.value.text,
        'imgUrl': downloadUrl.value,
        'deviceToken': deviceToken.value,
        'userId': userDoc.id, // Use the unique document ID
      });

      showToastMsg('User registered successfully');
      Get.to(const LoginPage(), transition: Transition.cupertino);
    } catch (e) {
      showToastMsg('Failed to register user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    name.value.clear();
    email.value.clear();
    phone.value.clear();
    gender.value.clear();
    dob.value.clear();
    password.value.clear();
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
}
