import 'package:equatable/equatable.dart';

import '../../../data/models/all_request_item_model.dart';

abstract class RequestItemsState  extends Equatable {
  const RequestItemsState();

  @override
  List<Object> get props => [];
}

class RequestItemsInitial extends RequestItemsState {}
class RequestItemsLoading extends RequestItemsState {}
class RequestItemsFailure extends RequestItemsState {
  final String errorMessage;

  const RequestItemsFailure(this.errorMessage);
}
class RequestItemsSuccess extends RequestItemsState {
  final List<AllRequestItemModel> allRequestItems;

  const RequestItemsSuccess(this.allRequestItems);
}