import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loy_eat/controllers/home_controller.dart';
import 'package:loy_eat/controllers/new_order_card_controller.dart';
import 'package:loy_eat/controllers/order_controller.dart';
import 'package:loy_eat/screens/order_detail_screen.dart';
import 'package:loy_eat/widgets/layout_widget/color.dart';
import 'package:loy_eat/widgets/screen_widget/home_screen_app_bar.dart';
import 'package:loy_eat/widgets/screen_widget/new_order_card.dart';
import 'package:loy_eat/widgets/screen_widget/order_empty_screen.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final newOrderController = Get.put(NewOrderCardController());
  final homeController = Get.put(HomeController());
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: lightGray,
        appBar: HomeScreenAppBar(),
        body: Obx(() => controller.orderAccept.value == true && controller.emptyScreen.value == false ? OrderDetailScreen() : OrderEmptyScreen()),
        bottomSheet: Obx(() => newOrderController.newOrderId.value != '' && homeController.isOnline.value == true && controller.orderAccept.value == false ? NewOrderCard() : const SizedBox()),
      ),
    );
  }
}