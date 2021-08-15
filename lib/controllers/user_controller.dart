import 'dart:convert';
import 'package:agraapp/models/user_class.dart';
import 'package:http/http.dart';
import 'package:agraapp/globals/globals.dart' as globals;

class UserController {
  Future<dynamic> registerUser(User user) async {
    try {
      Map<String, String> header = {
        "Content-type": "application/json; charset=UTF-8"
      };
      Map<String, dynamic> data = {
        'phone': user.phone,
        'password': user.password,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'user_type': user.userType,
      };
      Response response = await post(globals.apiUrl + '/api/user/register/init',
          headers: header, body: jsonEncode(data));
      var responseJson = jsonDecode(response.body);
      if (responseJson['status'] == globals.positive_status) {
        String temp_token = "Bearer ";
        //print(response.body);
        String jsonToken = responseJson['data']['token'];
        globals.user_token = temp_token + jsonToken;
        globals.typeToken = temp_token +
            responseJson['data'][responseJson['data']['user_type']]['token'];
        print(globals.typeToken);
        globals.user_info = new User.fromJson(responseJson);
        return 1;
      } else {
        print(response.body);
        var err_msg = responseJson["data"]['messages'];
        return err_msg;
      }
    } catch (e) {
      print(e);
      return "Error Registering User.";
    }
  }

  Future<Map> loginUser(String phone, String password) async {
    print("entered");
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "application/json; charset=UTF-8"
      };
      Map<String, dynamic> data = {
        'phone': phone,
        'password': password,
      };

      Response response = await post(globals.apiUrl + '/api/user/login',
          headers: header, body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      if (responseJson['status'] == globals.neutral_status) {
        String temp_token = "Bearer ";
        result['value'] = 1;
        result['data'] = responseJson['data']['user_type'];
        globals.user_token = temp_token + responseJson['data']['token'];
        //print(responseJson['data']['farmer']);
        globals.typeToken =
            temp_token + responseJson['data'][result['data']]['token'];
        globals.user_info = new User.fromJson(responseJson);
        print(globals.typeToken);
        //print(responseJson);
        return result;
      } else {
        result['value'] = -1;
        // result['data'] = "Invalid Login Details";
        result['data'] = responseJson['message'];
        print(responseJson);
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error logging user in";
      return result;
    }
  }
}
