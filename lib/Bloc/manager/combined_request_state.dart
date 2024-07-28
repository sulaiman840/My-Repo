import 'package:equatable/equatable.dart';
import '../../../models/pending_course_model.dart';
import '../../../models/pending_beneficiary_request_model.dart';

abstract class CombinedRequestState extends Equatable {
  const CombinedRequestState();

  @override
  List<Object?> get props => [];
}

class CombinedRequestInitial extends CombinedRequestState {}

class CombinedRequestLoading extends CombinedRequestState {}

class CombinedRequestCoursesLoaded extends CombinedRequestState {
  final List<PendingRequest> pendingCourses;

  const CombinedRequestCoursesLoaded(this.pendingCourses);

  @override
  List<Object?> get props => [pendingCourses];
}

class CombinedRequestBeneficiariesLoaded extends CombinedRequestState {
  final List<DataRequest> pendingBeneficiaries;

  const CombinedRequestBeneficiariesLoaded(this.pendingBeneficiaries);

  @override
  List<Object?> get props => [pendingBeneficiaries];
}

class CombinedRequestError extends CombinedRequestState {
  final String message;

  const CombinedRequestError(this.message);

  @override
  List<Object?> get props => [message];
}
