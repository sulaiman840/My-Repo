import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _jwtTokenKey = 'jwt_token';
  static const _userRoleKey = 'role';
  static const _fcmTokenKey = 'fcm_token';
  static const _imageFilenameKey = 'image_filename';
  static const _pdfFilenameKey = 'pdf_filename';

  static Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, fcmToken);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  static Future<void> saveJwtToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenKey, token);
  }

  static Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenKey);
  }

  static Future<void> clearJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtTokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getJwtToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  static Future<void> saveImageFilename(String imageName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageFilenameKey, imageName);
  }

  static Future<String?> getImageFilename() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imageFilenameKey);
  }

  static Future<void> savePdfFilename(String pdfName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pdfFilenameKey, pdfName);
  }

  static Future<String?> getPdfFilename() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_pdfFilenameKey);
  }
}
