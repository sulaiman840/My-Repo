import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'expiring_soon_state.dart';

class ExpiringSoonCubit extends Cubit<ExpiringSoonState> {

  static ExpiringSoonCubit get(context) => BlocProvider.of(context);

  ExpiringSoonCubit(this.itemRepo) : super(ExpiringSoonItemsInitial());

  final ItemRepo itemRepo;
  int afterIncreasePaginate = 50;

  int increasePaginate({required int paginate}){
    afterIncreasePaginate = paginate + 50;
    emit(IncreasePaginateSuccess());
    return afterIncreasePaginate;
  }

  Future<void> fetchExpiringSoonItems({
    required int paginate,
  }) async {
    emit(ExpiringSoonItemsLoading());
    var result = await itemRepo.fetchExpiringSoonItems(
      paginate: paginate,
    );

    result.fold((failure) {
      emit(ExpiringSoonItemsFailure(failure.errorMessage));
    }, (showAllItemsExpiring) {
      emit(ExpiringSoonItemsSuccess(showAllItemsExpiring));
    },
    );
  }
}