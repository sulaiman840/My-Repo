import 'package:equatable/equatable.dart';

import '../../../data/models/search_items_model.dart';

abstract class SearchItemState  extends Equatable {
  const SearchItemState();

  @override
  List<Object> get props => [];
}

class SearchItemInitial extends SearchItemState {}
class SearchItemLoading extends SearchItemState {}
class SearchItemFailure extends SearchItemState {
  final String errorMessage;

  const SearchItemFailure(this.errorMessage);
}
class SearchItemSuccess extends SearchItemState {
  final SearchItemsModel allSearchItems;

  const SearchItemSuccess(this.allSearchItems);
}
class IncreasePaginateSuccess extends SearchItemState {}