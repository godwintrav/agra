import 'package:agraapp/models/farm_class.dart';
import 'package:agraapp/models/project_class.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'dart:convert';

class InvestorController {
  Future<List<Farm>> fetchallFarms() async {
    List<Farm> farms = [];
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.typeToken,
      };
      Response response =
          await post(globals.apiUrl + '/api/farm/all', headers: headers);
      //print(globals.apiUrl + '/api/farm/farmer/$farmerId');
      var responseJson = jsonDecode(response.body);
      //print(globals.typeToken);
      // print(responseJson['data']['farms'][0]);
      print(responseJson['data']['farms'][0]);
      if (responseJson['status'] == globals.neutral_status) {
        //print(responseJson['data']['farms']);
        farms = (responseJson['data']['farms'] as List)
            .map((farm) => Farm.fromJson(farm))
            .toList();

        return farms;
      } else {
        // print(responseJson['data']['farms']);
        print(responseJson);
        return farms;
      }
    } catch (e) {
      print(e);
      return farms;
    }
  }

  Future<List<Farm>> fetchSponsoredFarms() async {
    List<Farm> farms = [];
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.user_token
      };
      Map<String, dynamic> data = {
        'type': "investment",
        'status': 0,
      };
      Response response = await post(
          globals.apiUrl + '/api/project/farm/followed/${globals.user_info.id}',
          headers: headers,
          body: jsonEncode(data));
      //print(globals.apiUrl + '/api/farm/farmer/$farmerId');
      var responseJson = jsonDecode(response.body);
      //print(globals.typeToken);
      print(responseJson['data']['farm'][0]);
      if (responseJson['status'] == globals.neutral_status) {
        //print(responseJson['data']['farms']);
        farms = (responseJson['data']['farm'] as List)
            .map((farm) => Farm.fromJson(farm))
            .toList();

        return farms;
      } else {
        return farms;
      }
    } catch (e) {
      print(e);
      return farms;
    }
  }

  Future<List<Project>> fetchallProjects() async {
    List<Project> projects = [];
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.user_token
      };
      Response response =
          await post(globals.apiUrl + '/api/project/all', headers: headers);
      print(globals.apiUrl + '/api/project/all');
      var responseJson = jsonDecode(response.body);
      //print(globals.typeToken);
      print(responseJson);
      if (responseJson['status'] == globals.neutral_status) {
        //print(responseJson['data']['projects']);
        projects = (responseJson['data']['projects'] as List)
            .map((project) => Project.fromJson(project))
            .toList();
        return projects;
      } else {
        print(responseJson['data']['projects']);
        return projects;
      }
    } catch (e) {
      print(e);
      print('here');
      return projects;
    }
  }

  Future<Map> fetchExpectedReturns() async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "multipart/form-data",
        "Authorization": globals.typeToken,
      };
      Map<String, dynamic> data = {
        'type': "investment",
        'status': 0,
      };
      Response response = await post(
          globals.apiUrl +
              '/api/project/dashboard/investor/${globals.user_info.id}',
          headers: header,
          body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson['status'] == globals.neutral_status) {
        result['value'] = 1;
        result['data'] = responseJson['data']['total_expected_returns'];
        return result;
      } else {
        result['value'] = 2;
        result['data'] = responseJson['message'];
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error getting information";
      return result;
    }
  }

  Future<Map> fetchInvestedAmount() async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "multipart/form-data",
        "Authorization": globals.typeToken,
      };
      Map<String, dynamic> data = {
        'type': "investment",
        'status': 0,
      };
      Response response = await post(
          globals.apiUrl +
              '/api/project/dashboard/investor/${globals.user_info.id}',
          headers: header,
          body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson['status'] == globals.neutral_status) {
        result['value'] = 1;
        result['data'] = responseJson['data']['total_invested_amount'];
        return result;
      } else {
        result['value'] = 2;
        result['data'] = responseJson['message'];
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error getting information";
      return result;
    }
  }

  Future<Map> fetchNextEarningDate() async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "multipart/form-data",
        "Authorization": globals.typeToken
      };
      Map<String, dynamic> data = {
        'type': "investment",
        'status': 0,
      };
      Response response = await post(
          globals.apiUrl +
              '/api/project/dashboard/investor/${globals.user_info.id}',
          headers: header,
          body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson['status'] == globals.neutral_status) {
        result['value'] = 1;
        result['data'] = responseJson['data']['next_earning_date'];
        return result;
      } else {
        print('empty');
        result['value'] = 2;
        result['data'] = "Error getting information";
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error getting information";
      return result;
    }
  }

  Future<Map> fundFarmProject(
      int projectId, int userId, String type, double amount) async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "application/json; charset=UTF-8",
        "Authorization": globals.user_token,
      };

      Map<String, dynamic> data = {
        'project_id': projectId,
        'user_id': userId,
        'type': type,
        'amount': amount,
      };

      Response response = await post(globals.apiUrl + '/api/project/fund',
          headers: header, body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson['status'] == globals.positive_status) {
        result['value'] = 1;
        result['data'] = responseJson['message'];
        return result;
      } else {
        result['value'] = -1;
        result['data'] = responseJson['message'];
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error funding project";
      return result;
    }
  }
}
