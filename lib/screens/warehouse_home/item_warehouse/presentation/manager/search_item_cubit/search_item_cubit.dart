import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'search_item_state.dart';

class SearchItemCubit extends Cubit<SearchItemState> {

  static SearchItemCubit get(context) => BlocProvider.of(context);

  SearchItemCubit(this.itemRepo) : super(SearchItemInitial());

  final ItemRepo itemRepo;
  int afterIncreasePaginate = 50;

  int increasePaginate({required int paginate}){
    afterIncreasePaginate = paginate + 50;
    emit(IncreasePaginateSuccess());
    return afterIncreasePaginate;
  }

  Future<void> fetchSearchItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int status,
    required int minQuantity,
    required int maxQuantity,
    required int paginate,
}) async {
    emit(SearchItemLoading());
    var result = await itemRepo.fetchSearchItem(
      name: name,
      typeId: typeId,
      categoryId: categoryId,
      status: status,
      minQuantity: minQuantity,
      maxQuantity: maxQuantity,
      paginate: paginate,
    );

    result.fold((failure) {
      emit(SearchItemFailure(failure.errorMessage));
      log(failure.errorMessage);
    }, (showAllSearchItems) {
      emit(SearchItemSuccess(showAllSearchItems));
    },
    );
  }
}