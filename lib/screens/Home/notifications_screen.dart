import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/notification_message_model.dart';
import '../../services/notification_service.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/general_widgets/common_scaffold.dart';


class NotificationScreen extends StatefulWidget {
  final int userId;

  NotificationScreen({required this.userId});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> _notifications = [];
  final NotificationService _notificationService = NotificationService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationItem> notifications =
      await _notificationService.fetchNotificationsById(widget.userId);
      setState(() {
        _notifications = notifications;
      });
    } catch (error) {
      print('Failed to load notifications: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: _scaffoldKey,
      title: AppLocalizations.of(context).translate('notifications'),
      body: _notifications.isEmpty
          ? Center(
        child: Text(
          AppLocalizations.of(context).translate('no_notifications_found'),
          style: TextStyle(
            fontSize: 18,
            color: ColorManager.bc2,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Icon(
                Icons.notifications,
                color: ColorManager.bc5,
                size: 30,
              ),
              title: Text(
                notification.message.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorManager.bc5,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  notification.message.body,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.bc3,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
