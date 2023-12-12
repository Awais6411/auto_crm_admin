import 'package:auto_crm_admin/controllers/admin/admin_provider.dart';
import 'package:auto_crm_admin/views/common/widgets/custom_appbar.dart';
import 'package:auto_crm_admin/views/common/widgets/reuseable_elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/request/user/profile_update_request.dart';
import '../../common/widgets/inputfield_withborder.dart';

class AuctioneerProfile extends StatefulWidget {
  const AuctioneerProfile({super.key});

  @override
  State<AuctioneerProfile> createState() => _AuctioneerProfileState();
}

class _AuctioneerProfileState extends State<AuctioneerProfile> {
  bool isAdminLoggedin = false;
  bool isFirstTime = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  bool showIcon = false;
  String resetText = 'Reset password?';
  String title = 'Profile';
  String uName = '';
  String uPhone = '';
  String uEmail = '';
  String uLetter = '';
  var auctioneerId;
  List<Widget> dynamicInputFields = [];

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

  Future<void> _loadSharedPreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int storedValue = prefs.getInt('auctioneerId') ?? 0;

    String useremail = prefs.getString('email') ?? 'Null';

    String phone = prefs.getString('phone') ?? '+9363737737';

    String username = prefs.getString('fullName') ?? 'Null';

    String initial = username.isNotEmpty ? username[0].toUpperCase() : '?';
    setState(() {
      auctioneerId = storedValue;
      uLetter = initial;
      uEmail = useremail;
      uPhone = phone;
      uName = username;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadSharedPreferencesData();
  }

  Widget editIcon() {
    return const Icon(
      Icons.edit,
      size: 50,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = uName;
    phoneController.text = uPhone;
    emailController.text = uEmail;
    return Consumer<AdminNotifier>(
      builder: (context, auctioneerNotifier, child) {
        return Scaffold(
            appBar: customAppBar(
              onTap: () {
                Navigator.pop(context);
              },
              title: title,
              showActions: !showIcon,
              onPressed: () {
                setState(() {
                  showIcon = !showIcon;
                  title = 'Edit Profile';
                });
              },
            ),
            /*  AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 8, 99, 155),
              title: Text(title),
              actions: <Widget>[
                showIcon == false
                    ? IconButton(
                        padding: const EdgeInsets.only(right: 15),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            showIcon = !showIcon;
                            title = 'Edit Profile';
                          });
                        },
                      )
                    : Container(),
              ],
              leading: GestureDetector(
                onTap: () {
                  // Get.back();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 18, 131, 223),
                      borderRadius: BorderRadius.circular(30)),
                  child: Image.asset(
                    "assets/icons/arrow_back.png",
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            */

            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 248, 251, 252),
                    Color.fromARGB(255, 6, 137, 166)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      right: 140,
                      child: Center(
                          child: Container(
                        alignment: Alignment.center,
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 8, 99, 155),
                            borderRadius: BorderRadius.circular(70)),
                        child: Text(
                          uLetter,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                    Positioned(
                        top: 70,
                        right: 130,
                        child: showIcon == true ? editIcon() : Container()),
                    Positioned(
                      top: 250,
                      left: 20,
                      right: 20,
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            InputFieldWithBorder(
                              hintText: 'Full Name',
                              controller: nameController,
                              // validator: ValidationService.validateUsername,
                            ),
                            InputFieldWithBorder(
                              hintText: "Phone Number",
                              controller: phoneController,
                              // validator: ValidationService.validateUsername,
                            ),
                            InputFieldWithBorder(
                              hintText: "Email",
                              controller: emailController,

                              // validator: ValidationService.validatePassword,
                            ),
                            const SizedBox(height: 20),
                            showIcon == true
                                ? ReuseAbleElevatedButton(
                                    text: "Save Changes",
                                    width: 280,
                                    height: 40,
                                    onPressed: auctioneerNotifier.isLoading
                                        ? () {}
                                        : () {
                                            auctioneerNotifier.isLoading = true;
                                            ProfileUpdateReqModel model =
                                                ProfileUpdateReqModel(
                                                    email: emailController.text
                                                        .trim(),
                                                    userName: nameController
                                                        .text
                                                        .trim(),
                                                    auctioneerId: 1,
                                                    phone: phoneController.text
                                                        .trim());
                                            auctioneerNotifier
                                                .updateUserProfile(
                                                    model, context);
                                          })
                                : Container(),
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
                ),
              ),
            ));
      },
    );
  }
}
