import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project2/models/Auth%20Model/user_profile.dart';
import 'package:project2/services/Auth_Services/manger_profile_service.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final MangerProfileService apiService;

  UserProfileCubit(this.apiService) : super(UserProfileInitial());

  Future<void> getUserProfile() async {
    try {
      emit(UserProfileLoading());
      final userProfile = await apiService.fetchUserProfile();
      emit(UserProfileLoaded(userProfile));
    } catch (e) {
      print('Cubit error: $e');
      emit(UserProfileError('Failed to fetch user profile: $e'));
    }
  }
}
