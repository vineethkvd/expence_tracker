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
import '../../register/controller/registration_controller.dart';
import '../../register/repository/validator.dart';
import '../controller/add_task_controller.dart';

class SetTargetPage extends StatefulWidget {
  const SetTargetPage({super.key});

  @override
  State<SetTargetPage> createState() => _SetTargetPageState();
}

class _SetTargetPageState extends State<SetTargetPage> {
  final AddTaskController addTaskController = AddTaskController();
  void initState() {
    super.initState();
    addTaskController.fetchAllTasks();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Set Target',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontFamily: "poppinsSemiBold",
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_outlined,
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
                        Text('Fill target details',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.indigo,
                                fontFamily: "poppinsSemiBold")),
                        SizedBox(
                          height: 10.sp,
                        ),
                        _customTextField(
                          labelTxt: "Task Name",
                          hintTxt: "Enter task name",
                          controller: addTaskController.taskName.value,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        _customTextArea(
                          labelTxt: "Description",
                          hintTxt: "Enter description",
                          controller: addTaskController.taskDescription.value,
                          keyboardType: TextInputType.text,
                        ),
                        _customTextField(
                          readOnly: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                addTaskController.taskStartDate.value.text= (await addTaskController.openCalendar(
                                    context: context))!;
                              },
                              icon: const Icon(Icons.calendar_month)),
                          labelTxt: "Start Date",
                          hintTxt: 'Select start date',
                          validator: (value) =>
                              Validator.validateInput(input: value),
                          controller: addTaskController.taskStartDate.value,
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        _customTextField(
                          readOnly: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                try{
                                  addTaskController.taskEndDate.value.text= (await addTaskController.openCalendar(
                                      context: context))!;
                                }catch(e){
                                  print("$e");
                                }
                              },
                              icon: const Icon(Icons.calendar_month)),
                          labelTxt: "End Date",
                          hintTxt: 'Select end date',
                          validator: (value) =>
                              Validator.validateInput(input: value),
                          controller: addTaskController.taskEndDate.value,
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(
                          height: 10.sp,
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
                                                    await addTaskController
                                                        .pickImage(
                                                        ImageSource.camera);
                                                    if (imageFile != null) {
                                                      addTaskController
                                                          .document
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
                                                    await addTaskController
                                                        .pickImage(ImageSource
                                                        .gallery);
                                                    if (imageFile != null) {
                                                      addTaskController
                                                          .document
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
                          labelTxt: "Document",
                          hintTxt: 'Select document',
                          validator: (value) =>
                              Validator.validateInput(input: value),
                          controller: addTaskController.document.value,
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        _customTextField(
                          labelTxt: "Amount",
                          hintTxt: "Enter amount",
                          controller: addTaskController.amount.value,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(15.0),
                          elevation: 5.0,
                          child: InkWell(
                            onTap: () async {
                              if (addTaskController.taskName.value.text.isEmpty) {
                                addTaskController.showToastMsg("Enter task name");
                              } else if (addTaskController
                                  .taskDescription.value.text.isEmpty) {
                                addTaskController.showToastMsg("Enter description");
                              }else if (addTaskController
                                  .taskStartDate.value.text.isEmpty) {
                                addTaskController.showToastMsg("Select start date");
                              }else if (addTaskController
                                  .taskEndDate.value.text.isEmpty) {
                                addTaskController.showToastMsg("Select end date");
                              }else if (addTaskController
                                  .document.value.text.isEmpty) {
                                addTaskController.showToastMsg("Select document");
                              }else{
                                addTaskController.setTarget().then((_) {
                                  addTaskController.clearFields();
                                },);
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
                              child: addTaskController.isLoading.value
                                  ? Center(
                                  child: SizedBox(
                                      height: 20.sp,
                                      width: 20.sp,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                                  : Text('Add',
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
  Widget _customTextArea({
    required String labelTxt,
    required String hintTxt,
    required TextEditingController? controller,
    required TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
    IconButton? suffixIcon,
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintTxt,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontFamily: "poppinsRegular",
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 15.0), // Adjust padding
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
