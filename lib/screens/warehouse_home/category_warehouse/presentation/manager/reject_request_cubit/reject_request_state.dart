import 'package:equatable/equatable.dart';

import '../../../data/models/reject_request_model.dart';

abstract class RejectRequestState  extends Equatable {
  const RejectRequestState();

  @override
  List<Object> get props => [];
}

class RejectRequestInitial extends RejectRequestState {}
class RejectRequestLoading extends RejectRequestState {}
class RejectRequestFailure extends RejectRequestState {
  final String errorMessage;

  const RejectRequestFailure(this.errorMessage);
}
class RejectRequestSuccess extends RejectRequestState {
  final RejectRequestModel rejectResult;

  const RejectRequestSuccess(this.rejectResult);
}