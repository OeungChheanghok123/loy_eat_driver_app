import 'dart:convert';

class DriverModel {
  static const String collectionName = "drivers";
  static const String yobString = "YOB";
  static const String createAtString = "create_at";
  static const String driverIdString = "driver_id";
  static const String driverNameString = "driver_name";
  static const String genderString = "gender";
  static const String idCardString = "id_card";
  static const String imageString = "image";
  static const String locationString = "location";
  static const String referralCodeString = "referral_code";
  static const String shiftString = "shift";
  static const String statusString = "status";  
  static const String telString = "tel";
  static const String isOnlineString = "is_online";
  static const String vehicleString = "vehicle";

  String yob;
  String createAt;
  String driverId;
  String driverName;
  String gender;
  String idCard;
  String image;
  Map<String, dynamic> location;
  String referralCode;
  List shift;
  String status;
  String tel;
  bool isOnline;
  String vehicle;

  DriverModel({
    this.yob = '',
    this.createAt = '',
    this.driverId = '',
    this.driverName = '',
    this.gender = '',
    this.idCard = '',
    this.image = '',
    this.location = const {},
    this.referralCode = '',
    this.shift = const [],
    this.status = '',
    this.tel = '',
    this.vehicle = '',
    this.isOnline = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({yobString: yob});
    result.addAll({createAtString: createAt});
    result.addAll({driverIdString: driverId});
    result.addAll({driverNameString: driverName});
    result.addAll({genderString: gender});
    result.addAll({idCardString: idCard});
    result.addAll({imageString: image});
    result.addAll({locationString: location});
    result.addAll({referralCodeString: referralCode});
    result.addAll({shiftString: shift});
    result.addAll({statusString: status});
    result.addAll({telString: tel});
    result.addAll({isOnlineString: isOnline});
    result.addAll({vehicleString: vehicle});

    return result;
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      yob: map[yobString] ?? '',
      createAt: map[createAtString] ?? '',
      driverId: map[driverIdString] ?? '',
      driverName: map[driverNameString] ?? '',
      gender: map[genderString] ?? '',
      idCard: map[idCardString] ?? '',
      image: map[imageString] ?? '',
      location: map[locationString] ?? {},
      referralCode: map[referralCodeString] ?? '',
      shift: map[shiftString] ?? [],
      status: map[statusString] ?? '',
      tel: map[telString] ?? '',
      vehicle: map[vehicleString] ?? '',
      isOnline: map[isOnlineString] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) => DriverModel.fromMap(json.decode(source));
}