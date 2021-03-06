import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:loy_eat/controllers/page_controller.dart';
import 'package:loy_eat/fire_base_handler.dart';
import 'package:loy_eat/models/languages.dart';
import 'package:loy_eat/screens/instruction_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  //updateBadge(message);
  print(message.data.toString()); // ignore: avoid_print
  print(message.notification!.title); // ignore: avoid_print
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseNotifications firebaseNotifications = FirebaseNotifications();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      firebaseNotifications.setupFirebase(context);
    });

    // notification.where("isRead", isEqualTo: false).get().then((value) {
    //   FlutterAppBadger.updateBadgeCount(value.docs.length);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: "Loy Eat driver app for BuyLoy.com",
      initialRoute: "/",
      defaultTransition: Transition.noTransition,
      getPages: getRoutPage,
      home: const InstructionScreen(),
    );
  }
}

// CollectionReference notification = FirebaseFirestore.instance.collection('notification');
// Future<void> updateBadge(RemoteMessage message) async {
//   if (Platform.isAndroid) {
//     await Firebase.initializeApp();
//   }
//   notification.add({
//     'title': message.data['title'],
//     'body': message.data['body'],
//     'ref_id':message.data['ref_id'],
//     'isRead': false,
//     'dri_id': message.data['dri_id'],
//     'date' : message.data['date'],
//   }).catchError((error) => print('Failed to add user: $error')); // ignore: avoid_print, invalid_return_type_for_catch_error
//
//   notification.where("isRead", isEqualTo: false).get().then((value) {
//     FlutterAppBadger.updateBadgeCount(value.docs.length);
//   });
// }