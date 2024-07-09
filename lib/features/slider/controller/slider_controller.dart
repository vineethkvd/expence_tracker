import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../login/model/login_model.dart';
import '../model/slider_model.dart';

class SliderController extends GetxController {
  var sliderList = <SliderModel>[].obs;
  var isLoading = false.obs;
  var currentIndex=0.obs;
  Future<void> fetchSliderData() async {
    try {
      isLoading.value = true;

      // Fetch all documents from the "slider" collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('slider').get();

      // Process the documents and store them in sliderList
      sliderList.value = querySnapshot.docs.map((doc) {
        return SliderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

    } catch (e) {
      showToastMsg('Failed to fetch slider data: $e');
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
