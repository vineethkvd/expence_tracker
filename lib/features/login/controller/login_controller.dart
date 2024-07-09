import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expence_tracker/features/register/view/registeration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../home/home_page.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  var dropdownValuesGender = ['Male', 'Female', 'Others'];
  var dropdownValuesMarital = ['Married', 'Unmarried'];
  var isLoading = false.obs;
  RxBool passwordVisible = true.obs;
  void updateVisibility() {
    passwordVisible.toggle();
    update();
  }

  final Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<GlobalKey<FormState>> get formKey => _formKey;
  final Rx<TextEditingController> email = TextEditingController().obs;
  final Rx<TextEditingController> password = TextEditingController().obs;
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection('users');
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        LoginModel userModel =
            LoginModel.fromJson(userData as Map<String, dynamic>);
        if (userModel.password == password) {
          CacheHelper.saveData(
              "userId", userModel.userId.toString());
          showToastMsg('Login Success');
          Get.to(const HomePage(), transition: Transition.cupertino);
        } else {
          showToastMsg('Invalid password');
        }
      } else {
        showToastMsg('No user Id found');
      }
    } catch (e) {
      showToastMsg('Failed to login user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    email.value.clear();
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
