import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'consume_item_state.dart';

class ConsumeItemCubit extends Cubit<ConsumeItemState> {

  static ConsumeItemCubit get(context) => BlocProvider.of(context);

  ConsumeItemCubit(this.itemRepo) : super(ConsumeItemInitial());

  final ItemRepo itemRepo;

  Future<void> fetchConsumeItem({
    required int id,
    required int quantityConsume,
  }) async {
    emit(ConsumeItemLoading());
    var result = await itemRepo.fetchConsumeItem(
      id: id,
      quantityConsume: quantityConsume,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ConsumeItemFailure(failure.errorMessage));
    }, (consumeItem) {
      emit(ConsumeItemSuccess(consumeItem));
    },
    );
  }
}