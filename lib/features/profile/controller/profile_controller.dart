import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../login/model/login_model.dart';

class ProfileController extends GetxController {
  var loginModel = const LoginModel().obs;
  var isLoading = false.obs;
  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      var userID = await CacheHelper.getData('userId');
      if(userID !=null && userID.isNotEmpty){
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference users = firestore.collection('users');
        QuerySnapshot querySnapshot =
        await users.where('userId', isEqualTo: userID).get();
        if (querySnapshot.docs.isNotEmpty) {
          var userData = querySnapshot.docs.first.data();
          loginModel(LoginModel.fromJson(userData as Map<String, dynamic>));
        } else {
          showToastMsg('No user Id found $userID');
        }
      }else{
        showToastMsg('UserID is empty');
      }

    } catch (e) {
      showToastMsg('Failed to login user: $e');
    } finally {
      isLoading.value = false;
    }
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
