import 'package:auto_crm_admin/views/common/widgets/reuseable_elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/admin/admin_provider.dart';
import '../../../controllers/validators/validation_service.dart';
import '../../common/widgets/custom_rich_text.dart';
import '../../common/widgets/inputfield_withborder.dart';
import '../oppurtunities/users_list.dart';

class UserPasswordReset extends StatefulWidget {
  const UserPasswordReset({super.key});

  @override
  State<UserPasswordReset> createState() => _UserPasswordResetState();
}

class _UserPasswordResetState extends State<UserPasswordReset> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _adminLginFromKey = GlobalKey();
  String resetText = 'Reset password?';
  List<Widget> dynamicInputFields = [];
  void addDynamicInputField() {
    setState(() {
      dynamicInputFields.add(Padding(
          padding: const EdgeInsets.all(16.0),
          child: InputFieldWithBorder(
            hintText: "new password",
            controller: newPassword,
            obescureText: true,
          )));
    });
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNotifier>(
      builder: (context, adminNotifier, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 70, 79, 251),
                Color.fromARGB(255, 19, 249, 246)
              ], // Replace with your desired colors
              begin: Alignment.topLeft, // Adjust the starting point
              end: Alignment.bottomRight, // Adjust the ending point
            )),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'AutoCRM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.lock_outline,
                    size: 160,
                    color: Color.fromARGB(255, 57, 97, 184),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter your email, and we'll send you an link to change your password",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 18),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: double.maxFinite,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      child: Form(
                        key: _adminLginFromKey,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InputFieldWithBorder(
                                  hintText: "Email",
                                  controller: email,
                                  validator: ValidationService.validateUsername,
                                )),
                            const SizedBox(
                              height: 10,
                            ),

                            ReuseAbleElevatedButton(
                              text: "Send Email",
                              width: 45,
                              height: 280,
                              onPressed: () {},
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            // Spacer(),
                            // SizedBox(
                            //   height: 80,
                            // ),

                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomRichText(
                        text: "Don't have an account?  ",
                        childText: "Sign Up",
                        color: Colors.white,
                        size: 19,
                        fontWeight: FontWeight.w400,
                        childTxtColor: Colors.white,
                        childSize: 22,
                        childFW: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
