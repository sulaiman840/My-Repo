import 'package:equatable/equatable.dart';

import '../../../data/models/create_type_model.dart';

abstract class CreateTypeState extends Equatable {
  const CreateTypeState();

  @override
  List<Object> get props => [];
}

class CreateTypeInitial extends CreateTypeState {}
class CreateTypeLoading extends CreateTypeState {}
class CreateTypeFailure extends CreateTypeState {
  final String errorMessage;

  const CreateTypeFailure(this.errorMessage);
}
class CreateTypeSuccess extends CreateTypeState {
  final CreateTypeModel createResult;

  const CreateTypeSuccess(this.createResult);
}