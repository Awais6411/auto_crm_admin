import 'dart:convert';
import 'package:auto_crm_admin/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_constants.dart';
import '../../models/request/admin/admin_login.dart';
import '../../models/response/vehicle/vehicle.dart';
import '../../models/request/user/profile_update_request.dart';
import '../../models/response/user/user_res.dart';
import '../../services/helpers/admin_helper.dart';
import '../../views/ui/oppurtunities/choose_month.dart';

class AdminNotifier extends ChangeNotifier {
  late Future<List<UserResModel>> usersList;
  late Future<List<CarData>> allAuctioneerCarsList;
  late Future<CarData> carDetailsTesting;

  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  set obescureText(bool newState) {
    _obsecureText = newState;
    notifyListeners();
  }

  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;
  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _firsttime;
  bool get firsttime => _firsttime ?? false;
  set firsttime(newState) {
    _firsttime = newState;
    notifyListeners();
  }

  bool? _adminLoggedin;
  bool get adminLoggedin => _adminLoggedin ?? false;
  set adminLoggedin(bool newState) {
    _adminLoggedin = newState;
    notifyListeners();
  }

  String? _selectedDate;
  String get selectedDate => _selectedDate ?? 'Null Date';
  set selectedDate(String newValue) {
    _selectedDate = newValue;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    notifyListeners();
  }

  String? _auctioneerName;
  String get auctioneerName => _auctioneerName ?? '';
  set auctioneerName(String newValue) {
    _auctioneerName = newValue;
    notifyListeners();
  }

  String? _weekId;
  String get weekId => _weekId ?? 'Null Date';
  set weekId(String newValue) {
    _weekId = newValue;
    notifyListeners();
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  getUsersList(int auctioneerId, String weekId) {
    usersList = AuctioneerHelper.getUsersList(auctioneerId, weekId);
  }

  getCarDetailsByIdTesting(int carId) {
    carDetailsTesting = AuctioneerHelper.getCarDetailsById(carId);
  }

  getAllCarsByAuctioneerId(int auctioneerId, int userId, String weekId) {
    allAuctioneerCarsList =
        AuctioneerHelper.getAllCarsByAuctioneerId(auctioneerId, userId, weekId);
  }

  void updateCarStatus(
      int vehicleId, String saleStatus, String soldPrice, context) {
    AuctioneerHelper.updateCarStatus(vehicleId, saleStatus, soldPrice)
        .then((value) {
      if (value) {
        isLoading = false;
        AppConstants.showSnackbar(
            context, "Status updated", Colors.green.shade400);
        Navigator.pop(context);
      } else {
        isLoading = false;
        AppConstants.showSnackbar(
            context, 'Something went wrong try again', Colors.redAccent);
      }
    });
  }

  bool validateLoginAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  adminLogin(AuctioneerLoginReqModel model, context) async {
    AuctioneerHelper.auctioneerLogin(model).then((value) => {
          if (value)
            {
              isLoading = false,
              AppConstants.showSnackbar(
                  context, "Success", Colors.green.shade400),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseMonthScreen(),
                  ))
            }
          else
            {
              isLoading = false,
              AppConstants.showSnackbar(
                  context, "Please check credentials", Colors.red.shade400)
            }
        });
  }

  updateUserProfile(ProfileUpdateReqModel model, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AuctioneerHelper.updateUserProfile(model).then((value) async {
      var data = await jsonDecode(value.body);
      if (data['status'] == 200) {
        isLoading = false;
        await prefs.setString("fullName", model.userName);
        await prefs.setString("phone", model.phone);
        await prefs.setString("email", model.email);
        Navigator.pop(context);
        AppConstants.showSnackbar(context, "Success", Colors.green.shade400);
      } else {
        isLoading = false;
        AppConstants.showSnackbar(
            context, "Something went wrong", Colors.red.shade400);
      }
    });
  }

  resetPassword(String newPassword, context) async {
    AuctioneerHelper.passwordReset(newPassword).then((value) => {
          if (value)
            {
              AppConstants.showSnackbar(
                  context, "Password Reset", Colors.green.shade400),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLogin(),
                  ))
            }
          else
            {
              AppConstants.showSnackbar(
                  context, 'Please check credentials', Colors.red.shade400)
            }
        });
  }

  adminLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adminLoggedin', false);
    await prefs.setBool('entrypoint', false);
    await prefs.remove('adminToken');
  }
}
