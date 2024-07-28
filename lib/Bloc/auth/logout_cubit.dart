import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/login_service.dart';
import '../../core/utils/shared_preferences_helper.dart';

class LogoutCubit extends Cubit<void> {
  final LoginService _loginService;

  LogoutCubit(this._loginService) : super(null);

  Future<void> logout() async {
    try {
      await _loginService.logout();
      await SharedPreferencesHelper.clearJwtToken();
      await SharedPreferencesHelper.clearUserRole();

      emit(null);
    } catch (e) {
      print("Erorr with lougout");
    }
  }
}
