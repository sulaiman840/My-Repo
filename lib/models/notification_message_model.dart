class NotificationMessage {
  final String title;
  final String body;

  NotificationMessage({
    required this.title,
    required this.body,
  });

  factory NotificationMessage.fromJson(Map<String, dynamic> json) {
    return NotificationMessage(
      title: json['titleNotification'],
      body: json['bodyNotification'],
    );
  }
}

class NotificationItem {
  final String id;
  final NotificationMessage message;

  NotificationItem({
    required this.id,
    required this.message,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      message: NotificationMessage.fromJson(json['data']['message']),
    );
  }
}

class NotificationResponse {
  final List<NotificationItem> notifications;

  NotificationResponse({required this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    var notificationsJson = json['notifications'] as List;
    List<NotificationItem> notificationsList = notificationsJson
        .map((notificationJson) => NotificationItem.fromJson(notificationJson))
        .toList();

    return NotificationResponse(notifications: notificationsList);
  }
}
