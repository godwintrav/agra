import 'package:multi_image_picker/multi_image_picker.dart';

class Farm {
  String farmTitle;
  String farmLocation;
  String farmType;
  List<Asset> farmAttachments;
  DateTime farmEstablishDate;
  int farmerId;
  String farmImage;
  int id;

  Farm(
      {this.farmAttachments,
      this.farmEstablishDate,
      this.farmLocation,
      this.farmTitle,
      this.farmType,
      this.farmerId,
      this.farmImage,
      this.id});
  factory Farm.fromJson(Map<String, dynamic> parsedJson) {
    return Farm(
        farmEstablishDate: DateTime.parse(parsedJson['est_date']),
        farmLocation: parsedJson['location'],
        farmTitle: parsedJson['title'],
        farmType: parsedJson['type'],
        farmerId: int.parse(parsedJson['farmer_id']),
        farmImage: parsedJson['attachments'][0]['file'],
        id: parsedJson['id']);
  }
}
