import 'package:equatable/equatable.dart';

import '../../../data/models/item_by_id_model.dart';

abstract class ItemByIdState  extends Equatable {
  const ItemByIdState();

  @override
  List<Object> get props => [];
}

class ItemByIdInitial extends ItemByIdState {}
class ItemByIdLoading extends ItemByIdState {}
class ItemByIdFailure extends ItemByIdState {
  final String errorMessage;

  const ItemByIdFailure(this.errorMessage);
}
class ItemByIdSuccess extends ItemByIdState {
  final ItemByIdModel item;

  const ItemByIdSuccess(this.item);
}