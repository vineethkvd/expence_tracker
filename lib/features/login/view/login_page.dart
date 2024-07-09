import 'package:expence_tracker/features/register/view/registeration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../../core/utils/configs/styles/colors.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../../register/repository/validator.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
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
                padding: EdgeInsets.all(8.sp),
                color: Colors.white.withOpacity(0.8),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Login',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.indigo,
                              fontFamily: "poppinsBold")),
                      SizedBox(
                        height: 10.sp,
                      ),
                      _customTextField(
                        labelTxt: "Email",
                        hintTxt: "Enter email",
                        controller: _loginController.email.value,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _customTextField(
                        labelTxt: "Password",
                        obscureText: _loginController.passwordVisible.value,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _loginController.updateVisibility();
                            },
                            icon: Icon(
                              _loginController.passwordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                            color: Colors.black),
                        hintTxt: 'Enter password',
                        validator: (value) =>
                            Validator.validateInput(input: value),
                        controller: _loginController.password.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 5.0,
                        child: InkWell(
                          onTap: () async {
                            if (_loginController.email.value.text.isEmpty) {
                              _loginController.showToastMsg("Enter name");
                            } else if (_loginController
                                .password.value.text.isEmpty) {
                              _loginController.showToastMsg("Enter password");
                            } else {
                              _loginController.loginUser(
                                  _loginController.email.value.text.trim(),
                                  _loginController.password.value.text.trim());
                            }
                          },
                          child: Container(
                            height: 35.sp,
                            width: 120.sp,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child:  _loginController.isLoading.value
                                ? Center(
                                child: SizedBox(
                                    height: 20.sp,
                                    width: 20.sp,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ))):Text('Sign In',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontFamily: "poppinsSemiBold")),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black54,
                                  fontFamily: "poppinsSemiBold")),
                          TextButton(
                              onPressed: () {
                                Get.to(const RegistrationPage(),
                                    transition: Transition.cupertino);
                              },
                              child: Text("Register Now",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.indigo,
                                      fontFamily: "poppinsSemiBold")))
                        ],
                      ),
                    ],
                  ),
                )),
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
