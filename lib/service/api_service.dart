import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_task/model/profile_model.dart';
import 'package:test_task/model/trade_model.dart';
import '../utils/const.dart';

class ApiService {
  static const baseUrl = "https://peanut.ifxdb.com/api/ClientCabinetBasic";
  static const loginUrl = '$baseUrl/IsAccountCredentialsCorrect';
  static const accountSettingUrl = '$baseUrl/GetLastFourNumbersPhone';
  static const accountLastPhoneNumberUrl =
      '$baseUrl/GetAccountInformation';
  static const tradeUrl = '$baseUrl/GetOpenTrades';
  static const header = {"Content-Type": "application/json", "Accept": "*/*"};
  //user login
  Future<String> loginUser(String email, String password) async {
    var body = {
      "login": email,
      "password": password,
    };
    try {
      var response = await http.post(Uri.parse(loginUrl),
          body: jsonEncode(body), headers: header);
      log('login body ===${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await saveString(TOKEN, data['token']);
        await saveString(EMAIL, email);
        await saveString(PASSWORD, password);
        return "success";
      } else if (response.statusCode == 404) {
        return "Invalid Email, Please try again";
      } else if (response.statusCode == 500) {
        return "You could not login now";
      } else {
        return "Login failed";
      }
    } on SocketException {
      return "Sorry you are not connected with internet";
    } on TimeoutException {
      return "Sorry timeout please try again";
    }
  }

// get account settings data
  Future getAccountSettings() async {
    var token = await getStringPrefs(TOKEN);
    var email = await getStringPrefs(EMAIL);
    var body = {
      "login": email,
      "token": token,
    };
    log("body $body");
    try {
      var response = await http.post(Uri.parse(accountLastPhoneNumberUrl),
          body: jsonEncode(body), headers: header);
      log('response of account ===${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('token_invalid');
      } else if (response.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Something went wrong..Please try again later');
      }
    } on SocketException {
      throw Exception('Internet not found');
    } on TimeoutException {
      throw Exception('Timeout please try again');
    }
  }

  Future getTrade() async {
    var token = await getStringPrefs(TOKEN);
    var email = await getStringPrefs(EMAIL);
    var body = {
      "login": email,
      "token": token,
    };
    try {
      var response = await http.post(Uri.parse(tradeUrl),
          body: jsonEncode(body), headers: header);

      log('Trade List ===${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        return data.map((e) => TradeModel.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('token_invalid');
      } else if (response.statusCode == 500) {
        throw Exception('Server Error');
      } else {
        throw Exception('Something went wrong');
      }
    } on SocketException {
      throw Exception('Internet not found');
    } on TimeoutException {
      throw Exception('Timeout please try again');
    }
  }

}
