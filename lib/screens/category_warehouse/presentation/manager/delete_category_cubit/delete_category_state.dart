import 'package:equatable/equatable.dart';

abstract class DeleteCategoryState  extends Equatable {
  const DeleteCategoryState();

  @override
  List<Object> get props => [];
}

class DeleteCategoryInitial extends DeleteCategoryState {}
class DeleteCategoryLoading extends DeleteCategoryState {}
class DeleteCategoryFailure extends DeleteCategoryState {
  final String errorMessage;

  const DeleteCategoryFailure(this.errorMessage);
}
class DeleteCategorySuccess extends DeleteCategoryState {
  final dynamic deleteResult;

  const DeleteCategorySuccess(this.deleteResult);
}