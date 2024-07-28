import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'item_by_id_state.dart';

class ItemByIdCubit extends Cubit<ItemByIdState> {

  static ItemByIdCubit get(context) => BlocProvider.of(context);

  ItemByIdCubit(this.itemRepo) : super(ItemByIdInitial());

  final ItemRepo itemRepo;

  Future<void> fetchItemById({
    required int id,
  }) async {
    emit(ItemByIdLoading());
    var result = await itemRepo.fetchItemById(
      id: id,
    );

    result.fold((failure) {
      emit(ItemByIdFailure(failure.errorMessage));
    }, (showItem) {
      emit(ItemByIdSuccess(showItem));
    },
    );
  }
}