import 'package:flutter/material.dart';
import 'package:food_dashboard/src/features/rolechange/controller/roleform_controller.dart';
import 'package:food_dashboard/src/features/rolechange/screen/widget/role_form_submitted_widget.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../common_widgets/form/form_header_widget.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import 'widget/role_form_widget.dart';

class FillRoleForm extends StatelessWidget {
  const FillRoleForm({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final RoleFormController rfController = Get.put(RoleFormController());
    rfController.checkDocumentExists();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: isDark ? tWhiteColor : tDarkColor,
            ),
          ),
          title: Text(
            "Change Role",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: FormHeaderWidget(
                      image: tRoleChange,
                      title: "Become a Seller!",
                      subTitle: "Join us and gain side incomes",
                    ),
                  ),
                  (rfController.documentExistence.value == 0)
                      ? const RoleFormWidget()
                      : const SubmittedRoleFormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
