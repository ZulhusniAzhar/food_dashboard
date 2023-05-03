// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_dashboard/src/constants/sizes.dart';
import 'package:food_dashboard/src/features/item/screens/item_list_screen.dart';
import 'package:food_dashboard/src/features/profilendashboard/screens/profile/update1_profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../authentication/models/user_model.dart';
import '../../../post/screens/post_list_screen.dart';
import '../../controllers/profile_controller.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());
  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              controller.pickImage(ImageSource.gallery);
              // controller.updateUserImage(controller.profileImage);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  controller.chooseImage.value = true;
                },
              );
            },
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              controller.pickImage(ImageSource.camera);
              // controller.updateUserImage(controller.profileImage);
              Navigator.of(context).pop();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  controller.chooseImage.value = true;
                },
              );
            },
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final profileController = Get.put(ProfileController());

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.to(() => Dashboard());
      //       },
      //       icon: Icon(LineAwesomeIcons.angle_left,
      //           color: isDark ? tWhiteColor : tDarkColor)),
      //   title: Text(
      //     tProfile,
      //     style: Theme.of(context).textTheme.headline4,
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
      //             color: isDark ? tWhiteColor : tDarkColor)),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: FutureBuilder<UserModel?>(
                future: profileController.getUserDetail(),
                builder: (context, AsyncSnapshot<UserModel?> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                    image: NetworkImage(
                                        snapshot.data!.profilePhoto)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: tPrimaryColor),
                                child: IconButton(
                                  onPressed: () {
                                    showOptionsDialog(context);
                                  },
                                  icon: const Icon(
                                    LineAwesomeIcons.pen,
                                    size: 20,
                                  ),
                                  color: Colors.black,
                                  // size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${snapshot.data?.fullName} (${snapshot.data?.role})',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          '${snapshot.data?.phoneNo}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          '${snapshot.data?.email}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => Get.to(
                                // () => UpdateProfileScreen(uid: authRepo.user.uid)),
                                () => UpdateProfileScreen(
                                    user: UserModel(
                                        uid: snapshot.data!.uid,
                                        fullName: snapshot.data!.fullName,
                                        matricNo: snapshot.data!.matricNo,
                                        gender: snapshot.data!.gender,
                                        email: snapshot.data!.email,
                                        phoneNo: snapshot.data!.phoneNo,
                                        password: snapshot.data!.password,
                                        block: snapshot.data!.block,
                                        college: snapshot.data!.college,
                                        profilePhoto:
                                            snapshot.data!.profilePhoto,
                                        role: snapshot.data!.role))),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tPrimaryColor,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              tEditProfile,
                              style: TextStyle(color: tDarkColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),

                        //MENU
                        ProfileMenuWidget(
                          title: tMenu1,
                          icon: LineAwesomeIcons.cog,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: tMenu2,
                          icon: LineAwesomeIcons.wallet,
                          onPress: () {
                            Get.to(() => const ItemListScreen());
                          },
                        ),
                        ProfileMenuWidget(
                          title: tMenu3,
                          icon: LineAwesomeIcons.user_check,
                          onPress: () {
                            Get.to(() => const PostListScreen());
                          },
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ProfileMenuWidget(
                          title: tMenu4,
                          icon: LineAwesomeIcons.info,
                          onPress: () {},
                        ),
                        ProfileMenuWidget(
                          title: tMenu5,
                          icon: LineAwesomeIcons.alternate_sign_out,
                          endIcon: false,
                          textColor: Colors.red,
                          onPress: () {
                            AuthenticationRepository.instance.logout();
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
