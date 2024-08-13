import 'package:equatable/equatable.dart';

abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object?> get props => [];
}

class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}

class EducationLoaded extends EducationState {
  final String rateCompletedCourses;
  final String rateCompletedBeneficiary;
  final String rateProcessingBeneficiary;
  final int averageAge;

  const EducationLoaded({
    required this.rateCompletedCourses,
    required this.rateCompletedBeneficiary,
    required this.rateProcessingBeneficiary,
    required this.averageAge,
  });

  @override
  List<Object?> get props => [
    rateCompletedCourses,
    rateCompletedBeneficiary,
    rateProcessingBeneficiary,
    averageAge,
  ];
}

class EducationError extends EducationState {
  final String message;

  const EducationError(this.message);

  @override
  List<Object?> get props => [message];
}
