import 'package:expence_tracker/features/add_task/view/set_target.dart';
import 'package:expence_tracker/features/profile/view/profile_view.dart';
import 'package:expence_tracker/features/slider/view/widget/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:expence_tracker/core/utils/configs/styles/colors.dart';
import 'package:expence_tracker/core/utils/shared/constants/assets_pathes.dart';
import 'package:expence_tracker/features/add_task/controller/add_task_controller.dart';
import 'package:expence_tracker/features/add_task/view/add_task_page.dart';
import 'package:expence_tracker/features/add_task/view/view_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AddTaskController controller = Get.put(AddTaskController());

  @override
  void initState() {
    super.initState();
    controller.fetchAllTasks();
    controller.fetchTarget();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => const ProfilePage(),
                          transition: Transition.cupertino);
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Image.asset(AssetsPathes.smallAppLogo),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: SizedBox(
                height: 180.h,
                child: const SliderWidget(),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          elevation: 5.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color:Color(0xff4cb050),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: InkWell(
                              onTap: () async {

                              },
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Target',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: "poppinsSemibold",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: Get.width,
                                      color: Color(0xff3e8e41),
                                      child: Center(
                                          child: Obx(() => Text(
                                            '₹ ${controller.targetAmt.value}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontFamily: "poppinsSemibold",
                                            ),
                                          ),)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                          elevation: 5.0,
                          child: Ink(
                            decoration: BoxDecoration(
                              color:Color(0xffff5353),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: InkWell(
                              onTap: () async {

                              },
                              child: Container(
                                height: 150,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Utilized Expense',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: "poppinsSemibold",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: Get.width,
                                      color: Color(0xffcc0000),
                                      child: Center(
                                        child: Obx(() => Text(
                                          '₹ ${controller.totalAmt.value}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontFamily: "poppinsSemibold",
                                          ),
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSingleButtonCard(
                    title: 'Set Target',
                    color: Colors.blueAccent,
                    icon: Icons.man,
                    onTap: () {
                      Get.to(() => SetTargetPage(),
                          transition: Transition.native);
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildDoubleButtonCard(
                        title: 'Add Expense',
                        color: Colors.teal,
                        icon: Icons.arrow_circle_right,
                        onTap: () {
                          Get.to(() => const AddTaskPage(),
                              transition: Transition.native);
                        },
                      ),
                      const SizedBox(width: 15),
                      _buildDoubleButtonCard(
                        title: 'View Expense',
                        color: Color(0xFF947BF5),
                        icon: CupertinoIcons.money_dollar_circle_fill,
                        onTap: () {
                          Get.to(() => ViewTaskPage(),
                              transition: Transition.native);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleButtonCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
          elevation: 5.0,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "poppinsSemibold",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoubleButtonCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
          elevation: 5.0,
          child: Ink(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 150,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: "poppinsSemibold",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
