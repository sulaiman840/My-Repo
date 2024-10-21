import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/shared_preferences_helper.dart';

class UserRoleCubit extends Cubit<String?> {
  UserRoleCubit() : super(null);

  Future<void> fetchUserRole() async {
    final role = await SharedPreferencesHelper.getUserRole();
    emit(role);
  }
}
