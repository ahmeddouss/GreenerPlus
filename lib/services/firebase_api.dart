import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:greener_plus/widgets/risque_dialog/risque_dialog_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

// Foreground message handler
Future<void> handleForegroundMessage(RemoteMessage message) async {
  print('Handling a foreground message: ${message.messageId}');
}

class FirebaseApi {
  FirebaseApi._privateConstructor();

  static final FirebaseApi instance = FirebaseApi._privateConstructor();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    _fcmToken = await _firebaseMessaging.getToken();
    print('Token: $_fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }

  Future<String?> getFcmToken() async {
    if (_fcmToken == null) {
      _fcmToken = await _firebaseMessaging.getToken();
    }
    return _fcmToken;
  }

  Future<void> initFrontNotif(BuildContext context) async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Payload: ${message.data}');
      showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment:
                AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
            child: RisqueDialogWidget(
              messageText: message.notification?.body.toString(),
            ),
          );
        },
      );
    });
  }
}
