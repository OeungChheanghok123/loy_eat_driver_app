import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loy_eat/widgets/layout_widget/button_widget.dart';
import 'package:loy_eat/widgets/layout_widget/color.dart';
import 'package:loy_eat/widgets/layout_widget/svg_picture_widget.dart';
import 'package:loy_eat/widgets/layout_widget/text_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: white,
      appBar: null,
      body: body(context),
    );
  }

  Widget body (BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildLogoLoyEatWidget(context),
        _buildRowButtonWidget(context),
      ],
    );
  }

  Widget _buildLogoLoyEatWidget (BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: white,
      child: const SvgPictureWidget(
        imageString: 'assets/image/loy_eat_logo.svg',
        label: 'LoyEat Logo',
        boxFit: BoxFit.contain,
      ),
    );
  }
  Widget _buildRowButtonWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 50,
      child: SizedBox(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildButton("Log In".tr, rabbit, '/verify_phone_number'),
            _buildButton("Become a Driver?".tr, carrot, '/become_driver'),
          ],
        ),
      ),
    );
  }
  Widget _buildButton(String text, Color color, String page){
    return ButtonWidget(
      color: color,
      onPressed: () => Get.toNamed(page),
      child: TextWidget(
        text: text,
        color: white,
        size: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}