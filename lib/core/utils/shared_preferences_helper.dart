import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _jwtTokenKey = 'jwt_token';
  static const _userRoleKey = 'role_const';
  static const _userIdKey = 'id_const';

  static const _fcmTokenKey = 'fcm_token';
  static const _imageFilenameKey = 'image_filename';
  static const _pdfFilenameKey = 'pdf_filename';
  // Define a new key for the boolean value
  static const _checkFlagKey = 'check_flag';

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
  static Future<void> clearFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
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

  static Future<void> saveUserID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, id);
  }

  static Future<int?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);  // Corrected key
  }

  static Future<void> clearUserID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);  // Corrected key
  }
  static Future<void> saveCheckFlag(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_checkFlagKey, value);
  }

  static Future<bool?> getCheckFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_checkFlagKey);
  }

  static Future<void> clearCheckFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_checkFlagKey);
  }

}
