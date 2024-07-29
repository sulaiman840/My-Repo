import 'package:equatable/equatable.dart';

import '../../../data/models/all_items_model.dart';

abstract class GetAllItemsState  extends Equatable {
  const GetAllItemsState();

  @override
  List<Object> get props => [];
}

class GetAllItemsInitial extends GetAllItemsState {}
class GetAllItemsLoading extends GetAllItemsState {}
class GetAllItemsFailure extends GetAllItemsState {
  final String errorMessage;

  const GetAllItemsFailure(this.errorMessage);
}
class GetAllItemsSuccess extends GetAllItemsState {
  final AllItemsModel allItems;

  const GetAllItemsSuccess(this.allItems);
}
class IncreasePaginateSuccess extends GetAllItemsState {}