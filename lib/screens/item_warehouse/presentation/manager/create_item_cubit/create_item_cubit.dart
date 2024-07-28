import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'create_item_state.dart';

class CreateItemCubit extends Cubit<CreateItemState> {

  static CreateItemCubit get(context) => BlocProvider.of(context);

  CreateItemCubit(this.itemRepo) : super(CreateItemInitial());

  final ItemRepo itemRepo;

  Future<void> fetchCreateItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int quantity,
    required String description,
    required String expiredDate,
    required int minimumQuantity,
  }) async {
    emit(CreateItemLoading());
    var result = await itemRepo.fetchCreateItem(
      name: name,
      typeId: typeId,
      categoryId: categoryId,
      quantity: quantity,
      description: description,
      expiredDate: expiredDate,
      minimumQuantity: minimumQuantity,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateItemFailure(failure.errorMessage));
    }, (createItem) {
      emit(CreateItemSuccess(createItem));
    },
    );
  }
}