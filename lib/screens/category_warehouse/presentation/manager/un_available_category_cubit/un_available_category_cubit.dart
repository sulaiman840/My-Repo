import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'un_available_category_state.dart';

class RequestItemsCubit extends Cubit<RequestItemsState> {

  static RequestItemsCubit get(context) => BlocProvider.of(context);

  RequestItemsCubit(this.categoryRepo) : super(RequestItemsInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchRequestItems() async {
    emit(RequestItemsLoading());
    var result = await categoryRepo.fetchRequestItems();

    result.fold((failure) {
      emit(RequestItemsFailure(failure.errorMessage));
    }, (showRequestItems) {
      emit(RequestItemsSuccess(showRequestItems));
    },
    );
  }
}