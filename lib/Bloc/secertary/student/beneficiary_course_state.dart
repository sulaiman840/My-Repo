

import 'package:equatable/equatable.dart';

import '../../../models/Secertary Model/beneficiary_course_model.dart';
import '../../../models/Secertary Model/course_benficary_view_model.dart';

abstract class BeneficiaryCourseState extends Equatable {
  const BeneficiaryCourseState();

  @override
  List<Object?> get props => [];
}

class BeneficiaryCourseInitial extends BeneficiaryCourseState {}

class BeneficiaryCourseLoading extends BeneficiaryCourseState {}

class BeneficiaryCourseLoaded extends BeneficiaryCourseState {
  final List<BeneficiaryCourse> courses;

  const BeneficiaryCourseLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class BeneficiaryByCourseLoaded extends BeneficiaryCourseState {
  final List<BeneficiaryByCourse> beneficiary;

  const BeneficiaryByCourseLoaded(this.beneficiary);

  @override
  List<Object?> get props => [beneficiary];
}

class BeneficiaryCourseAdded extends BeneficiaryCourseState {}

class BeneficiaryCourseDeleted extends BeneficiaryCourseState {}

class BeneficiaryCourseError extends BeneficiaryCourseState {
  final String message;

  const BeneficiaryCourseError(this.message);

  @override
  List<Object?> get props => [message];
}
