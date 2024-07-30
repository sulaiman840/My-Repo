
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/Auth_Services/auth_services.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterService _registerService;

  RegisterCubit(this._registerService) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String number,
    required String password,
    required String role,
    required Uint8List imageBytes,
  }) async {
    emit(RegisterLoading());

    try {
      final user = await _registerService.register(
        name: name,
        email: email,
        number: number,
        password: password,
        role: role,
        imageBytes: imageBytes,
      );
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
