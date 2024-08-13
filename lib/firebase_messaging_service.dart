import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project2/core/utils/app_routes.dart';

class FirebaseMessagingService {
  static late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  static late GlobalKey<NavigatorState> navigatorKey;

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  static Future<void> initialize(GlobalKey<ScaffoldMessengerState> key, GlobalKey<NavigatorState> navKey) async {
    scaffoldMessengerKey = key;
    navigatorKey = navKey;

    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await requestPermission(messaging);

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('${message.notification?.title ?? "New Notification"}: ${message.notification?.body ?? ""}'),
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              Navigator.of(navigatorKey.currentContext!).pushNamed(AppRouter.notifications);
            },

          ),
        ),
      );
    });
  }

  static Future<void> requestPermission(FirebaseMessaging messaging) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  static Future<String?> getFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      if (token != null) {
        return token;
      } else {
        throw Exception("No FCM token found");
      }
    } catch (e) {
      print("Error retrieving FCM token: $e");
      await Future.delayed(const Duration(seconds: 5));
      return await getFcmToken();
    }
  }
}
