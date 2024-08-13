import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();

    // Listen for custom 'notification-received' event
    window.addEventListener('notification-received', (event) {
      final detail = (event as CustomEvent).detail as Map<String, dynamic>;
      setState(() {
        _notifications.add({
          'title': detail['title'],
          'body': detail['body'],
        });
      });

      // Update localStorage with the new notification
      window.localStorage['notifications'] = jsonEncode(_notifications);
    });
  }

  void _loadNotifications() {
    final notificationsJson = window.localStorage['notifications'];
    if (notificationsJson != null) {
      setState(() {
        _notifications = List<Map<String, dynamic>>.from(jsonDecode(notificationsJson));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            title: Text(notification['title']),
            subtitle: Text(notification['body']),
          );
        },
      ),
    );
  }
}
