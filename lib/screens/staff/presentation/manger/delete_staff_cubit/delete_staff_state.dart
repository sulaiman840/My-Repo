import 'package:equatable/equatable.dart';

import '../../../data/models/delete_staff_model.dart';

abstract class DeleteStaffState extends Equatable {
  const DeleteStaffState();

  @override
  List<Object> get props => [];
}

class DeleteStaffInitial extends DeleteStaffState {}
class DeleteStaffLoading extends DeleteStaffState {}
class DeleteStaffFailure extends DeleteStaffState {
  final String errorMessage;

  const DeleteStaffFailure(this.errorMessage);
}
class DeleteStaffSuccess extends DeleteStaffState {
  final DeleteStaffModel deleteResult;

  const DeleteStaffSuccess(this.deleteResult);
}