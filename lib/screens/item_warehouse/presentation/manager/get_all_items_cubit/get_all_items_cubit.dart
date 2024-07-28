import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'get_all_items_state.dart';

class GetAllItemsCubit extends Cubit<GetAllItemsState> {

  static GetAllItemsCubit get(context) => BlocProvider.of(context);

  GetAllItemsCubit(this.itemRepo) : super(GetAllItemsInitial());

  final ItemRepo itemRepo;
  int afterIncreasePaginate = 50;

  int increasePaginate({required int paginate}){
    afterIncreasePaginate = paginate + 50;
    emit(IncreasePaginateSuccess());
    return afterIncreasePaginate;
  }

  Future<void> fetchAllItems({
    required int paginate,
  }) async {
    emit(GetAllItemsLoading());
    var result = await itemRepo.fetchAllItems(
      paginate: paginate,
    );

    result.fold((failure) {
      emit(GetAllItemsFailure(failure.errorMessage));
    }, (showAllItems) {
      emit(GetAllItemsSuccess(showAllItems));
    },
    );
  }
}