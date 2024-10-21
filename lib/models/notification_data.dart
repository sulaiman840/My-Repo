class NotificationData {
  final String fcmToken;
  final String title;
  final String body;

  NotificationData({
    required this.fcmToken,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'Fcm_token': fcmToken,
      'messageNotification': {
        'titleNotification': title,
        'bodyNotification': body,
      },
    };
  }
}
