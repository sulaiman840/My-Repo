import 'core/utils/shared_preferences_helper.dart';

class Constants{
  static const baseUrl = "http://127.0.0.1:8000";

  static final token = SharedPreferencesHelper.getJwtToken();
}