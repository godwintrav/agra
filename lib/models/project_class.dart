import 'farm_class.dart';

class Project {
  int farmID;
  String detail;
  String type;
  double estimatedReturns;
  int duration;
  double requiredAmount;
  double percentageReturns;
  int id;
  Farm farm;

  Project(
      {this.detail,
      this.duration,
      this.estimatedReturns,
      this.farmID,
      this.percentageReturns,
      this.requiredAmount,
      this.type,
      this.id,
      this.farm});

  factory Project.fromJson(Map<String, dynamic> parsedJson) {
    return Project(
        detail: parsedJson['detail'],
        duration: int.parse(parsedJson['duration']),
        estimatedReturns: double.parse(parsedJson['estimated_returns']),
        farmID: int.parse(parsedJson['farm_id']),
        percentageReturns: double.parse(parsedJson['percentage_returns']),
        requiredAmount: double.parse(parsedJson['required_amount']),
        type: parsedJson['type'],
        id: parsedJson['id'],
        farm: Farm.fromJson(parsedJson['farm']));
  }

  // factory Project.fromJson(Map<String, dynamic> parsedJson) {
  //   return Project(
  //       detail: parsedJson['detail'],
  //       duration: parsedJson['duration'],
  //       estimatedReturns: parsedJson['estimated_returns'],
  //       farmID: parsedJson['farm_id'],
  //       percentageReturns: parsedJson['percentage_returns'],
  //       requiredAmount: parsedJson['required_amount'],
  //       type: parsedJson['type'],
  //       id: parsedJson['id'],
  //       farm: Farm.fromJson(parsedJson['farm']));
  // }
}
