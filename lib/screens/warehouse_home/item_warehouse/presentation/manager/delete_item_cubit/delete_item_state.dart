import 'package:equatable/equatable.dart';

abstract class DeleteItemState  extends Equatable {
  const DeleteItemState();

  @override
  List<Object> get props => [];
}

class DeleteItemInitial extends DeleteItemState {}
class DeleteItemLoading extends DeleteItemState {}
class DeleteItemFailure extends DeleteItemState {
  final String errorMessage;

  const DeleteItemFailure(this.errorMessage);
}
class DeleteItemSuccess extends DeleteItemState {
  final dynamic deleteResult;

  const DeleteItemSuccess(this.deleteResult);
}