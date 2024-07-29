import 'package:equatable/equatable.dart';

import '../../../data/models/update_item_model.dart';

abstract class UpdateItemState extends Equatable {
  const UpdateItemState();

  @override
  List<Object> get props => [];
}

class UpdateItemInitial extends UpdateItemState {}
class UpdateItemLoading extends UpdateItemState {}
class UpdateItemFailure extends UpdateItemState {
  final String errorMessage;

  const UpdateItemFailure(this.errorMessage);
}
class UpdateItemSuccess extends UpdateItemState {
  final UpdateItemModel updateResult;

  const UpdateItemSuccess(this.updateResult);
}