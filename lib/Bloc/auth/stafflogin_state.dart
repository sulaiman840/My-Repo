import '../../models/user_model.dart';

abstract class StaffLoginState {}

class StaffLoginInitial extends StaffLoginState {}

class StaffLoginLoading extends StaffLoginState {}

class StaffLoginSuccess extends StaffLoginState {
  final UserModel user;
  StaffLoginSuccess(this.user);
}

class StaffLoginFailure extends StaffLoginState {
  final String error;
  StaffLoginFailure(this.error);
}
