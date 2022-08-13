import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loy_eat/controllers/order_controller.dart';
import 'package:loy_eat/models/customer_model.dart';
import 'package:loy_eat/models/deliver_model.dart';
import 'package:loy_eat/models/merchant_model.dart';
import 'package:loy_eat/models/order_model.dart';
import 'package:loy_eat/models/remote_data.dart';
import 'package:loy_eat/widgets/layout_widget/color.dart';

class NewOrderCardController extends GetxController {
  final orderController = Get.put(OrderController());
  var newOrderId = ''.obs;
  var merchantId = '0'.obs;
  var customerId = '0'.obs;
  late Timer _timer;
  var startCounter = 60.obs;

  final _orderData = RemoteData<List<OrderModel>>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List<OrderModel>> get orderData => _orderData.value;

  final _merchantData = RemoteData<List<MerchantModel>>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List<MerchantModel>> get merchantData => _merchantData.value;

  final _customerData = RemoteData<List<CustomerModel>>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List<CustomerModel>> get customerData => _customerData.value;

  final _deliverData = RemoteData<List<DeliverModel>>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List<DeliverModel>> get deliverData => _deliverData.value;

  @override
  void onInit() {
    startTimer();
    _loadOrderData();
    super.onInit();
  }
  @override
  void onClose() {
    closeTimer();
    super.onClose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
        if (startCounter.value == 0) {
          timer.cancel();
          Get.defaultDialog(
            radius: 5,
            title: '',
            barrierDismissible: false,
            titleStyle: const TextStyle(fontSize: 10),
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(15),
            middleTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            middleText: 'The time is out, the delivery will auto to reject.',
            textConfirm: 'Confirm',
            confirmTextColor: white,
            buttonColor: rabbit,
            onConfirm: (){
              orderController.isNewOrder.value = true;
              Get.offNamed('/instruction');
              Get.back();
            },
          );
        } else {
          startCounter--;
        }
      },
    );
  }
  void closeTimer() {
    _timer.cancel();
  }
  void showDialogReject() {
    Get.defaultDialog(
      radius: 5,
      title: '',
      titleStyle: const TextStyle(fontSize: 10),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(15),
      middleTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      middleText: 'Are you sure to reject this delivery?',
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      confirmTextColor: white,
      cancelTextColor: rabbit,
      buttonColor: rabbit,
      onConfirm: (){
        orderController.isNewOrder.value = false;
        Get.back();
        Get.toNamed('/instruction');
        closeTimer();
      },
      onCancel:(){
        Get.back();
      },
    );
  }

  void _loadOrderData() {
    try {
      final data = FirebaseFirestore.instance.collection(OrderModel.collectionName).where(OrderModel.orderIdString, isEqualTo: orderController.orderId.value).snapshots();
      data.listen((result) {
        final orders = result.docs.map((e) => OrderModel.fromMap(e.data())).toList();
        merchantId.value = orders[0].merchantId;
        customerId.value = orders[0].customerId;
        newOrderId.value = orders[0].orderId;
        _loadMerchantData(merchantId.value);
        _loadCustomerData(customerId.value);
        _loadDeliverData(newOrderId.value);
        _orderData.value = RemoteData<List<OrderModel>>(status: RemoteDataStatus.success, data: orders);
      });
    } catch (ex) {
      _orderData.value = RemoteData<List<OrderModel>>(status: RemoteDataStatus.error, data: null);
    }
  }
  void _loadMerchantData(String id) {
    try {
      final data = FirebaseFirestore.instance.collection(MerchantModel.collectionName).where(MerchantModel.merchantIdString, isEqualTo: id).snapshots();
      data.listen((result) {
        final merchant = result.docs.map((e) => MerchantModel.fromMap(e.data())).toList();
        _merchantData.value = RemoteData<List<MerchantModel>>(status: RemoteDataStatus.success, data: merchant);
      });
    } catch (ex) {
      _merchantData.value = RemoteData<List<MerchantModel>>(status: RemoteDataStatus.error, data: null);
    }
  }
  void _loadCustomerData(String id) {
    try {
      final data = FirebaseFirestore.instance.collection(CustomerModel.collectionName).where(CustomerModel.customerIdString, isEqualTo: id).snapshots();
      data.listen((result) {
        final customer = result.docs.map((e) => CustomerModel.fromMap(e.data())).toList();
        _customerData.value = RemoteData<List<CustomerModel>>(status: RemoteDataStatus.success, data: customer);
      });
    } catch (ex) {
      _customerData.value = RemoteData<List<CustomerModel>>(status: RemoteDataStatus.error, data: null);
    }
  }
  void _loadDeliverData(String id) {
    try {
      final data = FirebaseFirestore.instance.collection(DeliverModel.collectionName).where(DeliverModel.orderIdString, isEqualTo: id).snapshots();
      data.listen((result) {
        final deliver = result.docs.map((e) => DeliverModel.fromMap(e.data())).toList();
        _deliverData.value = RemoteData<List<DeliverModel>>(status: RemoteDataStatus.success, data: deliver);
      });
    } catch (ex) {
      _deliverData.value = RemoteData<List<DeliverModel>>(status: RemoteDataStatus.error, data: null);
    }
  }
}