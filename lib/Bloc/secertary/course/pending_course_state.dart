import 'package:equatable/equatable.dart';
import '../../../models/pending_course_model.dart';


abstract class PendingRequestState extends Equatable {
  const PendingRequestState();

  @override
  List<Object> get props => [];
}

class PendingRequestInitial extends PendingRequestState {}

class PendingRequestLoading extends PendingRequestState {}

class PendingRequestLoaded extends PendingRequestState {
  final List<PendingRequest> pendingRequests;

  const PendingRequestLoaded(this.pendingRequests);

  @override
  List<Object> get props => [pendingRequests];
}

class PendingRequestError extends PendingRequestState {
  final String message;

  const PendingRequestError(this.message);

  @override
  List<Object> get props => [message];
}
