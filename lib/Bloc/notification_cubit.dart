import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCubit extends Cubit<int> {
  static const _notificationCountKey = 'notification_count';

  NotificationCubit() : super(0) {
    _loadNotificationCount();
  }

  void _loadNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_notificationCountKey) ?? 0;
    emit(count);
  }

  void increment() async {
    final prefs = await SharedPreferences.getInstance();
    final newCount = state + 1;
    await prefs.setInt(_notificationCountKey, newCount);
    emit(newCount);
  }

  void reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, 0);
    emit(0);
  }
}
