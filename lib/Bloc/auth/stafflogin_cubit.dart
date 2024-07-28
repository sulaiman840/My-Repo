import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../services/stafflogin_service.dart';
import 'stafflogin_state.dart';


class StaffLoginCubit extends Cubit<StaffLoginState> {
  final StaffLoginService _loginService;

  StaffLoginCubit(this._loginService) : super(StaffLoginInitial());

  Future<void> login({required String email, required String password, required String fcmToken}) async {
    emit(StaffLoginLoading());
    try {
      final user = await _loginService.login(
          email: email,
          password: password,
          fcmToken: fcmToken
      );
      await SharedPreferencesHelper.saveJwtToken(user.token);
      await SharedPreferencesHelper.saveUserRole(user.role);
      await SharedPreferencesHelper.saveFcmToken(fcmToken);

      print("LoginCubit: Emitting LoginSuccess state with user: $user");
      emit(StaffLoginSuccess(user));
    } catch (e) {
      print("Login error: $e");
      emit(StaffLoginFailure(e.toString()));
    }
  }
}
