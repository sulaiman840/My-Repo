import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'accept_category_state.dart';

class AcceptCategoryCubit extends Cubit<AcceptCategoryState> {

  static AcceptCategoryCubit get(context) => BlocProvider.of(context);

  AcceptCategoryCubit(this.categoryRepo) : super(AcceptCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchAcceptCategory({
  required int id,
}) async {
    emit(AcceptCategoryLoading());
    var result = await categoryRepo.fetchAcceptCategory(id: id);

    result.fold((failure) {
      emit(AcceptCategoryFailure(failure.errorMessage));
    }, (acceptResult) {
      emit(AcceptCategorySuccess(acceptResult));
    },
    );
  }
}