import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  static Future<void> initialize() async {
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await requestPermission(messaging);

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("A new message arrived in the foreground!");
      print("Message data: ${message.data}");
      if (message.notification != null) {
        print("Notification Title: ${message.notification!.title}, Body: ${message.notification!.body}");
      }
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
      // Retry mechanism
      await Future.delayed(Duration(seconds: 5));
      return await getFcmToken();
    }
  }
}
