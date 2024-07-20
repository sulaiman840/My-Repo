import 'package:equatable/equatable.dart';
import '../../../models/pending_beneficiary_request_model.dart';

abstract class PendingBeneficiaryState extends Equatable {
  const PendingBeneficiaryState();

  @override
  List<Object?> get props => [];
}

class PendingBeneficiaryInitial extends PendingBeneficiaryState {}

class PendingBeneficiaryLoading extends PendingBeneficiaryState {}

class PendingBeneficiaryLoaded extends PendingBeneficiaryState {
  final List<DataRequest> pendingRequests;

  const PendingBeneficiaryLoaded(this.pendingRequests);

  @override
  List<Object?> get props => [pendingRequests];
}

class PendingBeneficiaryError extends PendingBeneficiaryState {
  final String message;

  const PendingBeneficiaryError(this.message);

  @override
  List<Object?> get props => [message];
}
