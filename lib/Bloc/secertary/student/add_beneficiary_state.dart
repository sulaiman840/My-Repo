// // State Class
// import 'package:equatable/equatable.dart';
//
// import '../../../models/Secertary Model/add_model.dart';
//
// abstract class AddBeneficiaryState extends Equatable {
//   const AddBeneficiaryState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AddBeneficiaryInitial extends AddBeneficiaryState {}
//
// class AddBeneficiaryLoading extends AddBeneficiaryState {}
//
// class AddBeneficiarySuccess extends AddBeneficiaryState {
//   final CreatBeneficiaryModel response;
//
//   const AddBeneficiarySuccess(this.response);
//
//   @override
//   List<Object?> get props => [response];
// }
//
// class AddBeneficiaryError extends AddBeneficiaryState {
//   final String message;
//
//   const AddBeneficiaryError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
