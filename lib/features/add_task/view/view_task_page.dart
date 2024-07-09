import 'dart:ffi';

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
import '../model/view_task_model.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  final AddTaskController controller = AddTaskController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add all expense',
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FutureBuilder<List<ViewTaskModel>>(
                future: controller.fetchAllTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No tasks found'));
                  } else {
                    List<ViewTaskModel> tasks = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        ViewTaskModel task = tasks[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              task.taskName ?? '',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Text(
                                  task.taskDescription ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Start Date: ${task.taskStartDate}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'End Date: ${task.taskEndDate}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.black54),
                            onTap: () {
                              Get.to(() => TaskDetailPage(task: task));
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),

      ),
    );
  }
}

class TaskDetailPage extends StatelessWidget {
  final ViewTaskModel task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Expense Details',
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
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.sp),
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetsPathes.splashBackground),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.brown,
                  height: 500,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Card(
                        margin: EdgeInsets.all(12.0),
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task Name',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                task.taskName ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              Divider(
                                  height: 20.0, color: Colors.grey.shade400),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                task.taskDescription ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              Divider(
                                  height: 20.0, color: Colors.grey.shade400),
                              Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                task.taskStartDate ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              Divider(
                                  height: 20.0, color: Colors.grey.shade400),
                              Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                task.taskEndDate ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              Divider(
                                  height: 20.0, color: Colors.grey.shade400),
                              Text(
                                'Amount',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                task.amount ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              Divider(
                                  height: 20.0, color: Colors.black),
                              Text(
                                'Document',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppinsSemiBold",
                                ),
                              ),
                              SizedBox(height: 8.0),
                              task.document != null && task.document!.isNotEmpty
                                  ? Image.network(
                                      task.document!,
                                      height: 200,
                                      width: Get.width,
                                      fit: BoxFit.contain,
                                    )
                                  : Text(
                                      'No document attached',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
