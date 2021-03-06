import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loy_eat/controllers/verify_phone_number_controller.dart';

class OTPCodeController extends GetxController {
  VerifyPhoneNumberController verifyPhoneNumberController = Get.put(VerifyPhoneNumberController());
  FirebaseAuth auth = FirebaseAuth.instance;

  final List<TextEditingController> listController = [];
  var otp1 = TextEditingController();
  var otp2 = TextEditingController();
  var otp3 = TextEditingController();
  var otp4 = TextEditingController();
  var otp5 = TextEditingController();
  var otp6 = TextEditingController();

  late Timer _timer;
  var start = 60.obs;
  late var otpNumber = "".obs;
  var isOTPError = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    listController.add(otp1);
    listController.add(otp2);
    listController.add(otp3);
    listController.add(otp4);
    listController.add(otp5);
    listController.add(otp6);
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
  }
  void closeTimer() {
    _timer.cancel();
  }
  void numberClick(int index) async{
    if (index == 10){
      isOTPError.value = false;
      otp1.text = '';
      otp2.text = '';
      otp3.text = '';
      otp4.text = '';
      otp5.text = '';
      otp6.text = '';
    } else {
      if (index == 11){
        index = 0;
      }
      if (otp1.text == ''){
        otp1.text = '$index';
      } else if (otp1.text != '' && otp2.text == ''){
        otp2.text = '$index';
      } else if (otp1.text != '' && otp2.text != '' && otp3.text == ''){
        otp3.text = '$index';
      } else if (otp1.text != '' && otp2.text != '' && otp3.text != '' && otp4.text == ''){
        otp4.text = '$index';
      } else if (otp1.text != '' && otp2.text != '' && otp3.text != '' && otp4.text != '' && otp5.text == ''){
        otp5.text = '$index';
      } else if (otp1.text != '' && otp2.text != '' && otp3.text != '' && otp4.text != '' && otp5.text != '' && otp6.text == ''){
        otp6.text = '$index';
      }
    }
    otpNumber.value = (otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text).toString();
    if (otp6.text != ''){
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyPhoneNumberController.verificationIDReceived,
        smsCode: otpNumber.value,
      );

      await auth.signInWithCredential(credential).then((value) {
        if(otpNumber.value != credential.smsCode){
          isOTPError.value = true;
        }
        _timer.cancel();
        Get.offAllNamed('/instruction');
        print('you are logged in successfully'); // ignore: avoid_print
        print('code SMS: ${credential.smsCode}'); // ignore: avoid_print
      });
      // if (otpNumber.value == '123456'){
      //   _timer.cancel();
      //   Get.offAllNamed('/instruction');
      // }
      // else {
      //   isOTPError.value = true;
      // }
    }
  }
  void deleteNumberClick() {
    isOTPError.value = false;
    if (otp2.text == ''){
      otp1.text = '';
    } else if (otp3.text == ''){
      otp2.text = '';
    } else if (otp4.text == ''){
      otp3.text = '';
    } else if (otp5.text == ''){
      otp4.text = '';
    } else if (otp6.text == ''){
      otp5.text = '';
    } else if (otp6.text != ''){
      otp6.text = '';
    }
  }
}