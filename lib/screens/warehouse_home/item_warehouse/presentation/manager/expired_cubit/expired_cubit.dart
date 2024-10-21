import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'expired_state.dart';

class ExpiredCubit extends Cubit<ExpiredState> {

  static ExpiredCubit get(context) => BlocProvider.of(context);

  ExpiredCubit(this.itemRepo) : super(ExpiredItemsInitial());

  final ItemRepo itemRepo;
  int afterIncreasePaginate = 50;

  int increasePaginate({required int paginate}){
    afterIncreasePaginate = paginate + 50;
    emit(IncreasePaginateSuccess());
    return afterIncreasePaginate;
  }

  Future<void> fetchExpiredItems({
    required int paginate,
  }) async {
    emit(ExpiredItemsLoading());
    var result = await itemRepo.fetchExpiredItems(
      paginate: paginate,
    );

    result.fold((failure) {
      emit(ExpiredItemsFailure(failure.errorMessage));
    }, (showAllItemsExpired) {
      emit(ExpiredItemsSuccess(showAllItemsExpired));
    },
    );
  }
}