import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/errors/failures.dart';
import 'package:project2/screens/staff/data/repos/staff_repo.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_state.dart';

class FeaturedStaffCubit extends Cubit<FeaturedStaffState> {
  FeaturedStaffCubit(this.staffRepo) : super(FeaturedStaffInitial());

  final StaffRepo staffRepo;

  Future<void> fetchFeaturedStaff() async {
    emit(FeaturedStaffInitial());
    var result = await staffRepo.fetchAllStaffs();
    result.fold((failure) {
        emit(FeaturedStaffFailure(failure.errorMessage));
      }, (showStaff) {
        emit(FeaturedStaffSuccess(showStaff));
      }
    );
}
}