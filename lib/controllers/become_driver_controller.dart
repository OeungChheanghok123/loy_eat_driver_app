import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loy_eat/widgets/layout_widget/color.dart';

class BecomeDriverController extends GetxController {

  TextEditingController driverNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  var radioGenderValue = 0.obs;
  var dropDownDistrictValue = "".obs;
  var dropDownCommuneValue = "".obs;

  var isSelectedBike = false.obs;
  var isSelectedMotor = false.obs;
  var isSelectedRickshaw = false.obs;

  var isSelectMorning = false.obs;
  var isSelectAfternoon = false.obs;
  var isSelectEvening = false.obs;

  var bikeBorderVehicleColor = platinum.obs;
  var bikeBackgroundVehicleColor = white.obs;
  var motorBorderVehicleMotorColor = platinum.obs;
  var motorBackgroundVehicleBikeColor = white.obs;
  var rickshawBorderVehicleBikeColor = platinum.obs;
  var rickshawBackgroundVehicleBikeColor = white.obs;

  var morningTextScheduleColor  = black.obs;
  var morningBorderScheduleColor = silver.obs;
  var morningBackgroundScheduleColor = white.obs;
  var afternoonTextScheduleColor  = black.obs;
  var afternoonBorderScheduleColor = silver.obs;
  var afternoonBackgroundScheduleColor = white.obs;
  var eveningTextScheduleColor  = black.obs;
  var eveningBorderScheduleColor = silver.obs;
  var eveningBackgroundScheduleColor = white.obs;

  var selectImagePath = ''.obs;
  var selectImageSize = ''.obs;

  void selectGender(int index) {
    radioGenderValue.value = index;
  }
  void selectVehicle(int index) {
    if (index == 0){
      isSelectedBike.value = true;
      isSelectedMotor.value = false;
      isSelectedRickshaw.value = false;
    }
    if (index == 1) {
      isSelectedMotor.value = true;
      isSelectedBike.value = false;
      isSelectedRickshaw.value = false;
    }
    if (index == 2) {
      isSelectedRickshaw.value = true;
      isSelectedBike.value = false;
      isSelectedMotor.value = false;
    }

    if (isSelectedBike.value  == true){
      bikeBorderVehicleColor.value = rabbit;
      bikeBackgroundVehicleColor.value = rabbit;
    } else {
      bikeBorderVehicleColor.value = platinum;
      bikeBackgroundVehicleColor.value = white;
    }
    if (isSelectedMotor.value == true){
      motorBorderVehicleMotorColor.value = rabbit;
      motorBackgroundVehicleBikeColor.value = rabbit;
    } else {
      motorBorderVehicleMotorColor.value = platinum;
      motorBackgroundVehicleBikeColor.value = white;
    }
    if (isSelectedRickshaw.value  == true){
      rickshawBorderVehicleBikeColor.value = rabbit;
      rickshawBackgroundVehicleBikeColor.value = rabbit;
    } else {
      rickshawBorderVehicleBikeColor.value = platinum;
      rickshawBackgroundVehicleBikeColor.value = white;
    }
  }
  void selectSchedule(int index) {
    if (index == 0) {
      isSelectMorning.value = !isSelectMorning.value;
    }
    if (index == 1) {
      isSelectAfternoon.value = !isSelectAfternoon.value;
    }
    if(index == 2) {
      isSelectEvening.value = !isSelectEvening.value;
    }

    if (isSelectMorning.value  == true){
      morningTextScheduleColor.value = white;
      morningBackgroundScheduleColor.value = rabbit;
      morningBorderScheduleColor.value = none;
    } else {
      morningTextScheduleColor.value = black;
      morningBackgroundScheduleColor.value = white;
      morningBorderScheduleColor.value = silver;
    }
    if (isSelectAfternoon.value == true){
      afternoonTextScheduleColor.value = white;
      afternoonBackgroundScheduleColor.value = rabbit;
      afternoonBorderScheduleColor.value = none;
    } else {
      afternoonTextScheduleColor.value = black;
      afternoonBackgroundScheduleColor.value = white;
      afternoonBorderScheduleColor.value = silver;
    }
    if (isSelectEvening.value  == true){
      eveningTextScheduleColor.value = white;
      eveningBackgroundScheduleColor.value = rabbit;
      eveningBorderScheduleColor.value = none;
    } else {
      eveningTextScheduleColor.value = black;
      eveningBackgroundScheduleColor.value = white;
      eveningBorderScheduleColor.value = silver;
    }
  }
  Future pickImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null){
      selectImagePath.value = pickedImage.path;
      selectImageSize.value = ((File(selectImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2) + " Mb";
    } else {
      Get.snackbar('Error', 'No Image selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: white, colorText: black,);
    }
  }
}