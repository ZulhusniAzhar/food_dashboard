// import 'dart:js';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/features/profilendashboard/controllers/profile_controller.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/dashboard/dashboard.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/auth.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/page.dart';
import '../../../../constants/text_strings.dart';
import '../../../authentication/models/user_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserModel user;
  UpdateProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController matricNoController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
    fullNameController = TextEditingController(text: widget.user.fullName);
    phoneNoController = TextEditingController(text: widget.user.phoneNo);
    matricNoController = TextEditingController(text: widget.user.matricNo);
    blockController = TextEditingController(text: widget.user.block);
    collegeController = TextEditingController(text: widget.user.college);
    genderController = TextEditingController(text: widget.user.gender);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneNoController.dispose();
    matricNoController.dispose();
    blockController.dispose();
    collegeController.dispose();
    genderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: isDark ? tWhiteColor : tDarkColor,
          ),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:
                          Image(image: NetworkImage(widget.user.profilePhoto)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),

              //Form fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                          label: Text(tFullName),
                          prefixIcon: Icon(Icons.person_outline_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      controller: matricNoController,
                      decoration: const InputDecoration(
                          label: Text(tMatricNo),
                          prefixIcon: Icon(Icons.numbers_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      controller: genderController,
                      decoration: const InputDecoration(
                          label: Text("Gender"),
                          prefixIcon: Icon(Icons.boy_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          label: Text(tEmail),
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      controller: phoneNoController,
                      decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          prefixIcon: Icon(Icons.numbers_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    // TextFormField(
                    //   controller: passController,
                    //   decoration: const InputDecoration(
                    //       label: Text(tPassword),
                    //       prefixIcon: Icon(Icons.password_rounded)),
                    // ),
                    // const SizedBox(
                    //   height: tFormHeight,
                    // ),
                    TextFormField(
                      controller: blockController,
                      decoration: const InputDecoration(
                          label: Text("Block"),
                          prefixIcon: Icon(Icons.house_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight,
                    ),
                    TextFormField(
                      controller: collegeController,
                      decoration: const InputDecoration(
                          label: Text("College"),
                          prefixIcon: Icon(Icons.house_rounded)),
                    ),
                    const SizedBox(
                      height: tFormHeight + 20,
                    ),

                    //button bawah
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ProfileController.updateUser(UserModel(
                                  uid: widget.user.uid,
                                  fullName: fullNameController.text.trim(),
                                  matricNo: matricNoController.text.trim(),
                                  gender: genderController.text.trim(),
                                  email: emailController.text.trim(),
                                  phoneNo: phoneNoController.text.trim(),
                                  password: passwordController.text.trim(),
                                  block: blockController.text.trim(),
                                  college: collegeController.text.trim(),
                                  profilePhoto: widget.user.profilePhoto,
                                  role: widget.user.role))
                              .then((value) => Get.to(() => Dashboard(
                                    pageIdx: 3,
                                  )));
                          // Get.back());

                          Get.snackbar("Success", "Data Successfully updated");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(
                          tEditProfile,
                          style: TextStyle(color: tDarkColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: tFormHeight + 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<String?>(
                            future: profileController.printCreationTime(),
                            builder: (context, snapshot) {
                              return Text.rich(
                                TextSpan(
                                  text: tJoined,
                                  style: const TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                        text: snapshot.data,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                  ],
                                ),
                              );
                            }),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor:
                        //           Colors.redAccent.withOpacity(0.1),
                        //       elevation: 0,
                        //       foregroundColor: Colors.red,
                        //       shape: const StadiumBorder(),
                        //       side: BorderSide.none),
                        //   child: const Text(tDelete),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
