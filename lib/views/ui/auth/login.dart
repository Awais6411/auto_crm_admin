import 'package:auto_crm_admin/controllers/admin/admin_provider.dart';
import 'package:auto_crm_admin/models/request/admin/admin_login.dart';
import 'package:auto_crm_admin/views/common/widgets/reuseable_elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/widgets/inputfield_withborder.dart';
import 'login_request.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool isAdminLoggedin = false;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferencesData();
  }

  _loadSharedPreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool("adminLoggedin") ?? false;
    bool firstTime = prefs.getBool("firsttime") ?? false;
    setState(() {
      isAdminLoggedin = loggedIn;
      isFirstTime = firstTime;
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
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

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        behavior: SnackBarBehavior
            .floating, // Duration for how long the Snackbar is displayed
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 80,
            left: 80),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminNotifier>(
      builder: (context, auctioneerNotifier, child) {
        return Scaffold(
            body: Stack(
          children: [
            Positioned(
              child: Container(
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
                      height: 150,
                    ),
                    const Center(
                      child: Text(
                        'AutoCRM',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        // height: double.maxFinite,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          child: Form(
                            key: _loginFormKey,
                            child: Column(
                              children: [
                                InputFieldWithBorder(
                                  hintText: "Email",
                                  controller: email,
                                  // validator: ValidationService.validateUsername,
                                ),
                                InputFieldWithBorder(
                                  hintText: "Password",
                                  controller: password,
                                  obescureText: true,
                                  // validator: ValidationService.validatePassword,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ReuseAbleElevatedButton(
                                    text: "Login",
                                    width: 280,
                                    height: 40,
                                    onPressed: auctioneerNotifier.isLoading
                                        ? () {}
                                        : () {
                                            if (email.text.isEmpty ||
                                                password.text.isEmpty) {
                                              _showSnackbar(context,
                                                  "Please provide credentials");
                                            } else if (_loginFormKey
                                                .currentState!
                                                .validate()) {
                                              auctioneerNotifier.isLoading =
                                                  true;
                                              AuctioneerLoginReqModel model =
                                                  AuctioneerLoginReqModel(
                                                      email: email.text.trim(),
                                                      password:
                                                          password.text.trim());
                                              auctioneerNotifier.adminLogin(
                                                  model, context);
                                            }
                                          }),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UserPasswordReset(),
                                        ));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (auctioneerNotifier.isLoading)
              Positioned(
                  child: Container(
                color: Colors.transparent.withOpacity(0.6),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ))
          ],
        ));
      },
    );
  }
}
