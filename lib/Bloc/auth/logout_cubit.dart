import 'package:flutter_bloc/flutter_bloc.dart';
import '../../firebase_messaging_service.dart';
import '../../services/Auth_Services/login_service.dart';
import '../../core/utils/shared_preferences_helper.dart';

class LogoutCubit extends Cubit<void> {
  final LoginService _loginService;

  LogoutCubit(this._loginService) : super(null);

  Future<void> logout() async {
    try {
   //   final String? role = await SharedPreferencesHelper.getUserRole();
      final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();

      if (manager_falge != null) {
        await SharedPreferencesHelper.clearCheckFlag();
      }
      await SharedPreferencesHelper.clearUserRole();
      await _loginService.logout();
      await SharedPreferencesHelper.clearJwtToken();
//tttt
      await FirebaseMessagingService.clearFcmToken();
   //   await SharedPreferencesHelper.clearFcmToken();

      ////ttt
      emit(null);
    } catch (e) {
      print("Erorr with lougout");
    }
  }
}
