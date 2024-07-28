import '../../../models/Secertary Model/beneficiary_model.dart';

abstract class BeneficiaryState {}

class BeneficiaryInitial extends BeneficiaryState {}

class BeneficiaryLoading extends BeneficiaryState {}

class BeneficiaryLoaded extends BeneficiaryState {
  final List<DataBeneficiary> beneficiaries;
  BeneficiaryLoaded(this.beneficiaries);
}

class BeneficiaryDetailsLoaded extends BeneficiaryState {
  final DataBeneficiary beneficiary;
  BeneficiaryDetailsLoaded(this.beneficiary);
}

class BeneficiaryError extends BeneficiaryState {
  final String message;
  BeneficiaryError(this.message);
}
