import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'update_item_state.dart';

class UpdateItemCubit extends Cubit<UpdateItemState> {

  static UpdateItemCubit get(context) => BlocProvider.of(context);

  UpdateItemCubit(this.itemRepo) : super(UpdateItemInitial());

  final ItemRepo itemRepo;

  Future<void> fetchUpdateItem({
    required int id,
    required String name,
    required String expiredDate,
    required int quantity,
    required String description,
    required int typeId,
    required int categoryId,
  }) async {
    emit(UpdateItemLoading());
    var result = await itemRepo.fetchUpdateItem(
      id: id,
      name: name,
      expiredDate: expiredDate,
      quantity: quantity,
      description: description,
      typeId: typeId,
      categoryId: categoryId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateItemFailure(failure.errorMessage));
    }, (updateItem) {
      emit(UpdateItemSuccess(updateItem));
    },
    );
  }
}