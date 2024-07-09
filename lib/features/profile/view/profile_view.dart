import 'package:cached_network_image/cached_network_image.dart';
import 'package:expence_tracker/features/login/view/login_page.dart';
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
import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../../core/utils/shared/constants/assets_pathes.dart';
import '../controller/profile_controller.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController =
  ProfileController();
  @override
  void initState() {
    super.initState();
    _profileController.fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          'Profile Page',
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
            child: SingleChildScrollView(
                child: Obx(
              () => Container(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 80.sp),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 100.sp, // Size of the circular border
                                width: 100.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      50.r), // Circular border
                                  border: Border.all(
                                    color: const Color(0xffe50829),
                                    width: 3.sp,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70.r),
                                  child: Container(
                                    height: 90.sp,
                                    width: 90.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      color: Colors.black12,
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                      '${_profileController.loginModel.value.imgUrl}',
                                      placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                              BorderRadius.circular(8.r),
                                            ),
                                            child: Icon(CupertinoIcons.person),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _buildProfileDetail(
                        label: "Name",
                        value:
                        _profileController.loginModel.value.name!,
                      ),
                      SizedBox(height: 16.w),
                      _buildProfileDetail(
                        label: "Phone",
                        value:
                        _profileController.loginModel.value.phone!,
                      ),
                      SizedBox(height: 16.w),
                      _buildProfileDetail(
                        label: "Email",
                        value:
                        _profileController.loginModel.value.email!,
                      ),
                      SizedBox(height: 16.w),
                      _buildProfileDetail(
                        label: "Gender",
                        value:
                        _profileController.loginModel.value.gender!,
                      ),
                      SizedBox(height: 16.w),
                      _buildProfileDetail(
                        label: "Date of Birth",
                        value:
                        _profileController.loginModel.value.dob!,
                      ),
                      SizedBox(height: 16.w),
                      Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 5.0,
                        child: InkWell(
                          onTap: () async {
                            showLogoutDialog(context);
                          },
                          child: Container(
                            height: 35.sp,
                            width: 120.sp,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Log out',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontFamily: "poppinsSemiBold")),
                          ),
                        ),
                      ),
                    ]),
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                fontFamily: "poppinsRegular",
              ),
            ),
          ],
        ),
        SizedBox(height: 8.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            color:Colors.white,
            fontFamily: "poppinsSemiBold",
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.white,
        ),
      ],
    );
  }
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              fontFamily: "poppinsSemiBold",
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontFamily: "poppinsRegular",
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              onPressed: () {
                CacheHelper.clearData("userId");
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
