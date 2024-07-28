import 'package:equatable/equatable.dart';

import '../../../data/models/create_item_model.dart';

abstract class CreateItemState extends Equatable {
  const CreateItemState();

  @override
  List<Object> get props => [];
}

class CreateItemInitial extends CreateItemState {}
class CreateItemLoading extends CreateItemState {}
class CreateItemFailure extends CreateItemState {
  final String errorMessage;

  const CreateItemFailure(this.errorMessage);
}
class CreateItemSuccess extends CreateItemState {
  final CreateItemModel createResult;

  const CreateItemSuccess(this.createResult);
}