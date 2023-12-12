import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/request/admin/admin_login.dart';
import '../../models/response/vehicle/vehicle.dart';
import '../../models/request/user/profile_update_request.dart';
import '../../models/response/admin/admin_login.dart';
import '../../models/response/user/user_res.dart';
import '../config.dart';

class AuctioneerHelper {
  static var client = http.Client();

  static Future<http.Response> updateUserProfile(
      ProfileUpdateReqModel model) async {
    var url = "${Config.OFFICE_BASE_URL}${Config.PROFILE_UPDATE_URL}";
    // "http://192.168.10.12:5000/api/v1/auctioneer/updateprofile";
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    http.Response response =
        await client.patch(uri, headers: headers, body: jsonEncode(model));
    return response;
  }

  static Future<bool> auctioneerLogin(AuctioneerLoginReqModel model) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var url = "${Config.OFFICE_BASE_URL}${Config.AUCTIONEER_LOGIN_URL}";
    var uri = Uri.parse(url);
    var response =
        await client.post(uri, headers: headers, body: jsonEncode(model));
    var data = jsonDecode(response.body);
    if (data['status'] == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var auctioneer =
          AuctioneerLoginResModelFromJson(jsonEncode(data['data'][0]));
      int auctioneerId = auctioneer.auctionerId;

      await prefs.setInt('auctioneerId', auctioneerId);
      await prefs.setString('email', auctioneer.email!);
      await prefs.setString('fullName', auctioneer.firstName);
      await prefs.setBool('auctioneerLoggedin', true);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> passwordReset(String newPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var auctioneerId = prefs.getInt('AuctioneerId');
    final Map<String, dynamic> requestBody = {
      "newPassword": newPassword,
      "AuctioneerId": auctioneerId
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};
    var url = "${Config.OFFICE_BASE_URL}${Config.AUCTIONEER_RESETPASS_URL}";
    var uri = Uri.parse(url);
    var response =
        await client.post(uri, headers: headers, body: jsonEncode(requestBody));
    var data = jsonDecode(response.body);
    if (data['status'] == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("firsttime", false);
      await prefs.setBool("isPasswordReset", true);

      return true;
    } else {
      return false;
    }
  }

  static Future<List<UserResModel>> getUsersList(
      int auctioneerId, String weekId) async {
    var url = "${Config.OFFICE_BASE_URL}${Config.ALLUSERS_URL}";
    // "http://192.168.10.12:5000/api/v1/auctioneer/getauctioneerusers";

    var uri = Uri.parse(url);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> mapObj = {'auctioneerId': 5, 'weekId': 49};

    try {
      var response =
          await client.post(uri, headers: headers, body: jsonEncode(mapObj));

      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        var usersList = UserDataFromJson(jsonEncode(data['data']));

        return usersList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('error message${e}');
    }
  }

  static Future<List<CarData>> getAllCarsByAuctioneerId(
      int auctioneerId, int userId, String weekId) async {
    var url =
        // "http://192.168.10.12:5000/api/v1/user/allcarsbyauctioneerid";
        "https://crmapis.grandunicornhotels.com/api/v1/user/allcarsbyauctioneerid";
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> mapObject = {
      "auctioneer_id": 1,
      "user_id": 1,
      "weekId": 50,
    };
    http.Response response =
        await client.post(uri, headers: headers, body: jsonEncode(mapObject));
    var data = await jsonDecode(response.body);
    if (data['status'] == 200) {
      print(data);

      var result = CarDataFromJson(jsonEncode(data['data']));

      return result;
    } else {
      return [];
    }
  }

  static Future<CarData> getCarDetailsById(int carId) async {
    var url =
        //  "${Config.OFFICE_BASE_URL}${Config.ca}/$carId";
        "https://crmapis.grandunicornhotels.com/api/v1/vehicle/carDetails/$carId";
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    http.Response response = await client.get(
      uri,
      headers: headers,
    );
    var data = await jsonDecode(response.body);
    var carObject = CarData.fromJson(data['data'][0]);
    return carObject;
  }

  static Future<bool> updateCarStatus(
      int vehicleId, String saleStatus, String soldPrice) async {
    var url =
        "${Config.OFFICE_BASE_URL}${Config.UPDATE_CAR_STATUS_URL}/$vehicleId";
    // "http://192.168.10.12:5000/api/v1/auctioneer/updatecarstatus/$vehicleId";
    var uri = Uri.parse(url);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> mapObject = {
      "sale_status": saleStatus,
      'sold_price': soldPrice
    };

    http.Response response =
        await client.post(uri, headers: headers, body: jsonEncode(mapObject));

    var data = await jsonDecode(response.body);
    if (data['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
