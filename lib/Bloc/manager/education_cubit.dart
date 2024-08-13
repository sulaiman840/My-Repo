import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/Manager_Services/education_service.dart';
import 'education_state.dart';

class EducationCubit extends Cubit<EducationState> {
  final EducationService _educationService;

  EducationCubit(this._educationService) : super(EducationInitial());

  Future<void> fetchEducationData() async {
    try {
      emit(EducationLoading());
      final rateCompletedCourses = await _educationService.fetchRateCompletedCourses();
      final rateCompletedBeneficiary = await _educationService.fetchRateCompletedBeneficiary();
      final rateProcessingBeneficiary = await _educationService.fetchRateProcessingBeneficiary();
      final averageAge = await _educationService.fetchAverageAge();

      emit(EducationLoaded(
        rateCompletedCourses: rateCompletedCourses,
        rateCompletedBeneficiary: rateCompletedBeneficiary,
        rateProcessingBeneficiary: rateProcessingBeneficiary,
        averageAge: averageAge,
      ));
    } catch (e) {
      emit(EducationError(e.toString()));
    }
  }
}
