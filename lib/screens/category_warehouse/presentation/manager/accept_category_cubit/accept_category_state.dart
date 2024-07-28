import 'package:equatable/equatable.dart';

import '../../../data/models/accept_request_model.dart';

abstract class AcceptRequestState  extends Equatable {
  const AcceptRequestState();

  @override
  List<Object> get props => [];
}

class AcceptRequestInitial extends AcceptRequestState {}
class AcceptRequestLoading extends AcceptRequestState {}
class AcceptRequestFailure extends AcceptRequestState {
  final String errorMessage;

  const AcceptRequestFailure(this.errorMessage);
}
class AcceptRequestSuccess extends AcceptRequestState {
  final AcceptRequestModel acceptResult;

  const AcceptRequestSuccess(this.acceptResult);
}