import 'package:agraapp/models/farm_class.dart';
import 'package:agraapp/models/project_class.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:agraapp/globals/globals.dart' as globals;
import 'dart:convert';

import 'package:http_parser/http_parser.dart';

class FarmController {
  Future<Map> createFarm(Farm farm) async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.typeToken,
      };
      Uri uri = Uri.parse(globals.apiUrl + '/api/farm/create');
      MultipartRequest request = MultipartRequest("POST", uri);
      request.headers.addAll(headers);
      request.fields['title'] = farm.farmTitle;
      request.fields['location'] = farm.farmLocation;
      request.fields['type'] = farm.farmType;
      request.fields['est_date'] = farm.farmEstablishDate.toString();
      request.fields['farmer_id'] = jsonEncode(farm.farmerId);
      request.fields['user_id'] = jsonEncode(globals.user_info.user_id);
      for (int i = 0; i < farm.farmAttachments.length; i++) {
        ByteData byteData = await farm.farmAttachments[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();

        MultipartFile multipartFile = MultipartFile.fromBytes(
            'attachments[]', imageData,
            filename: farm.farmAttachments[i].name,
            contentType:
                MediaType("image", getImageType(farm.farmAttachments[i].name)));
        request.files.add(multipartFile);
        //print(multipartFile);
      }
      var response = await request.send();
      String strResponse = await response.stream.bytesToString();
      print(strResponse);
      var responseJson = jsonDecode(strResponse);
      if (responseJson['status'] == globals.positive_status) {
        result['value'] = 1;
        result['data'] = responseJson['message'];
        //print(result);
        return result;
      } else {
        result['value'] = -1;
        result['data'] = responseJson['message'];
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "No Internet connection.";
      return result;
    }
  }

  Future<List<Farm>> fetchFarmerFarms(int farmerId) async {
    List<Farm> farms = [];
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.typeToken,
      };
      Response response = await get(
          globals.apiUrl + '/api/farm/farmer/$farmerId',
          headers: headers);
      //print(globals.apiUrl + '/api/farm/farmer/$farmerId');
      var responseJson = jsonDecode(response.body);
      //print(globals.typeToken);
      print(responseJson['data']['farms'][0]);
      if (responseJson['status'] == globals.neutral_status) {
        //print(responseJson['data']['farms']);
        farms = (responseJson['data']['farms'] as List)
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

  Future<Map> createFarmProject(Project project) async {
    var result = new Map<String, dynamic>();
    try {
      Map<String, String> header = {
        "Content-type": "application/json; charset=UTF-8",
        "Authorization": globals.typeToken,
      };
      Map<String, dynamic> data = {
        'farm_id': project.farmID,
        'detail': project.detail,
        'type': project.type,
        'estimated_returns': project.estimatedReturns,
        'duration': project.duration,
        'required_amount': project.requiredAmount,
        'percentage_returns': project.percentageReturns,
      };

      Response response = await post(globals.apiUrl + '/api/project/create',
          headers: header, body: jsonEncode(data));
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson['status'] == globals.positive_status) {
        result['value'] = 1;
        result['data'] = responseJson['data']['message'];
        //print(globals.typeToken);
        print(responseJson);
        return result;
      } else {
        result['value'] = -1;
        // result['data'] = "Invalid Login Details";
        result['data'] = responseJson['message'];
        //print(responseJson);
        return result;
      }
    } catch (e) {
      print(e);
      result['value'] = -1;
      result['data'] = "Error logging user in";
      return result;
    }
  }

  Future<List<Project>> fetchFarmerProjects(int farmerId) async {
    List<Project> projects = [];
    try {
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": globals.user_token,
      };
      Response response = await post(
          globals.apiUrl + '/api/project/farmer/$farmerId',
          headers: headers);
      //print(globals.apiUrl + '/api/farm/farmer/$farmerId');
      var responseJson = jsonDecode(response.body);
      //print(globals.typeToken);
      print(responseJson['data']['projects']);
      if (responseJson['status'] == globals.neutral_status) {
        //print(responseJson['data']['projects']);
        projects = (responseJson['data']['projects'] as List)
            .map((project) => Project.fromJson(project))
            .toList();
        return projects;
      } else {
        return projects;
      }
    } catch (e) {
      print(e);
      return projects;
    }
  }

  String getImageType(String str) {
    int ind = str.lastIndexOf('.');
    String imgExt = str.substring(ind + 1);
    return imgExt;
  }
}
