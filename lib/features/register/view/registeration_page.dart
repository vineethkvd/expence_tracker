import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../controller/registration_controller.dart';
import '../repository/validator.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final RegistrationController _registrationController =
      RegistrationController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(10.sp),
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetsPathes.splashBackground))),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 500,
              padding: EdgeInsets.all(8.sp),
              color: Colors.white.withOpacity(0.8),
              child: SingleChildScrollView(
                  child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Register',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.indigo,
                            fontFamily: "poppinsBold")),
                    SizedBox(
                      height: 10.sp,
                    ),
                    _customTextField(
                      labelTxt: "Name",
                      hintTxt: "Enter name",
                      controller: _registrationController.name.value,
                      keyboardType: TextInputType.text,
                    ),
                    _customTextField(
                      labelTxt: "Email",
                      hintTxt: "Enter email",
                      controller: _registrationController.email.value,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _customTextField(
                      labelTxt: "Phone",
                      hintTxt: "Enter phone number",
                      controller: _registrationController.phone.value,
                      keyboardType: TextInputType.number,
                    ),
                    _customTextField(
                      readOnly: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                children: _registrationController
                                    .dropdownValuesGender
                                    .map((String value) {
                                  return InkWell(
                                    onTap: () {
                                      _registrationController.gender.value.text =
                                          value;
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 8, top: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black26,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        height: 40,
                                        width: Get.width,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "palatino",
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        },
                        icon: Icon(CupertinoIcons.chevron_down),
                      ),
                      labelTxt: "Gender",
                      hintTxt: 'Select Gender',
                      validator: (value) =>
                          Validator.validateInput(input: value),
                      controller: _registrationController.gender.value,
                      keyboardType: TextInputType.text,
                    ),
                    _customTextField(
                      readOnly: true,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            await _registrationController.openCalendar(
                                context: context);
                          },
                          icon: const Icon(Icons.calendar_month)),
                      labelTxt: "Date of birth",
                      hintTxt: 'Select date',
                      validator: (value) =>
                          Validator.validateInput(input: value),
                      controller: _registrationController.dob.value,
                      keyboardType: TextInputType.datetime,
                    ),
                    _customTextField(
                      readOnly: true,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 100,
                                width: Get.width,
                                color: Colors.black26,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black26,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                File? imageFile =
                                                    await _registrationController
                                                        .pickImage(
                                                            ImageSource.camera);
                                                if (imageFile != null) {
                                                  _registrationController
                                                      .photo
                                                      .value
                                                      .text = imageFile.path;
                                                }
                                              },
                                              icon: Icon(
                                                CupertinoIcons.camera,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.brown,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black26,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                File? imageFile =
                                                    await _registrationController
                                                        .pickImage(ImageSource
                                                            .gallery);
                                                if (imageFile != null) {
                                                  _registrationController
                                                      .photo
                                                      .value
                                                      .text = imageFile.path;
                                                }
                                              },
                                              icon: Icon(
                                                CupertinoIcons.photo,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.image_outlined),
                      ),
                      labelTxt: "Photo",
                      hintTxt: 'Select image',
                      validator: (value) =>
                          Validator.validateInput(input: value),
                      controller: _registrationController.photo.value,
                      keyboardType: TextInputType.datetime,
                    ),
                    _customTextField(
                      labelTxt: "Password",
                      obscureText: _registrationController.passwordVisible.value,
                      suffixIcon: IconButton(
                          onPressed: () {
                            _registrationController.updateVisibility();
                          },
                          icon: Icon(
                            _registrationController.passwordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black54,
                          ),
                          color: Colors.black),
                      hintTxt: 'Enter password',
                      validator: (value) =>
                          Validator.validateInput(input: value),
                      controller: _registrationController.password.value,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(15.0),
                      elevation: 5.0,
                      child: InkWell(
                        onTap: () async {
                          if (_registrationController.name.value.text.isEmpty) {
                            _registrationController.showToastMsg("Enter name");
                          } else if (_registrationController
                              .email.value.text.isEmpty) {
                            _registrationController.showToastMsg("Enter email");
                          } else if (_registrationController
                              .phone.value.text.isEmpty) {
                            _registrationController.showToastMsg("Enter phone");
                          } else if (_registrationController
                              .gender.value.text.isEmpty) {
                            _registrationController
                                .showToastMsg("Select gender");
                          } else if (_registrationController
                              .dob.value.text.isEmpty) {
                            _registrationController
                                .showToastMsg("Select date of birth");
                          } else if (_registrationController
                              .password.value.text.isEmpty) {
                            _registrationController
                                .showToastMsg("Enter password");
                          } else {
                            _registrationController.userRegistration().then(
                              (_) {
                                // registrationController.clearFields();
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 35.sp,
                          width: 120.sp,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(15.0.sp),
                          ),
                          child: _registrationController.isLoading.value
                              ? Center(
                                  child: SizedBox(
                                      height: 20.sp,
                                      width: 20.sp,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                              : Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontFamily: "poppinsSemiBold")),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required String labelTxt,
    required String hintTxt,
    required TextEditingController? controller,
    required TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
    IconButton? suffixIcon,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintTxt,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontFamily: "poppinsRegular",
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
          labelText: labelTxt,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontFamily: "poppinsRegular",
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.brown),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.brown),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
