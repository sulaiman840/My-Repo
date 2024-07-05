import 'package:equatable/equatable.dart';

import '../../../data/models/get_type_id_model.dart';

abstract class DeleteTypeState  extends Equatable {
  const DeleteTypeState();

  @override
  List<Object> get props => [];
}

class DeleteTypeInitial extends DeleteTypeState {}
class DeleteTypeLoading extends DeleteTypeState {}
class DeleteTypeFailure extends DeleteTypeState {
  final String errorMessage;

  const DeleteTypeFailure(this.errorMessage);
}
class DeleteTypeSuccess extends DeleteTypeState {
  final dynamic deleteResult;

  const DeleteTypeSuccess(this.deleteResult);
}