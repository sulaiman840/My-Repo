import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'delete_item_state.dart';

class DeleteItemCubit extends Cubit<DeleteItemState> {

  static DeleteItemCubit get(context) => BlocProvider.of(context);

  DeleteItemCubit(this.itemRepo) : super(DeleteItemInitial());

  final ItemRepo itemRepo;

  Future<void> fetchDeleteItem({
    required int id,
  }) async {
    emit(DeleteItemLoading());
    var result = await itemRepo.fetchDeleteItem(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteItemFailure(failure.errorMessage));
    }, (deleteItem) {
      emit(DeleteItemSuccess(deleteItem));
    },
    );
  }
}