import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loy_eat/models/notification_model.dart';
import 'package:loy_eat/screens/account_screen.dart';
import 'package:loy_eat/screens/home_screen.dart';
import 'package:loy_eat/screens/order_screen.dart';
import 'package:loy_eat/screens/report_screen.dart';
import 'package:loy_eat/widgets/layout_widget/color.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {

  int _currentTabIndex = 0;

  final _listTabPages = <Widget>[
    const HomeScreen(),
    const ReportScreen(),
    const OrderScreen(),
    const AccountScreen(),
  ];

  final _pageBottonNavBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Report'),
    const BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Order'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    assert(_listTabPages.length == _pageBottonNavBarItems.length);

    return Scaffold(
      body: _listTabPages[_currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _pageBottonNavBarItems,
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: rabbit,
        backgroundColor: lightGray,
        elevation: 15,
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initNotification(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);   // ignore: avoid_print
        print(message.notification!.body); // ignore: avoid_print
      }

     // LocalNotificationService.onDidReceiveLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
}