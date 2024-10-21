import 'package:equatable/equatable.dart';

import '../../../data/models/consume_item_model.dart';

abstract class ConsumeItemState extends Equatable {
  const ConsumeItemState();

  @override
  List<Object> get props => [];
}

class ConsumeItemInitial extends ConsumeItemState {}
class ConsumeItemLoading extends ConsumeItemState {}
class ConsumeItemFailure extends ConsumeItemState {
  final String errorMessage;

  const ConsumeItemFailure(this.errorMessage);
}
class ConsumeItemSuccess extends ConsumeItemState {
  final ConsumeItemModel consumeResult;

  const ConsumeItemSuccess(this.consumeResult);
}