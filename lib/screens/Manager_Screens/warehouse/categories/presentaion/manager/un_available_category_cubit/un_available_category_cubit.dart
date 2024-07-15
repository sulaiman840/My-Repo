import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'un_available_category_state.dart';

class UnAvailableCategoryCubit extends Cubit<UnAvailableCategoryState> {

  static UnAvailableCategoryCubit get(context) => BlocProvider.of(context);

  UnAvailableCategoryCubit(this.categoryRepo) : super(UnAvailableCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchUnAvailableCategories() async {
    emit(UnAvailableCategoryLoading());
    var result = await categoryRepo.fetchUnAvailableCategories();

    result.fold((failure) {
      emit(UnAvailableCategoryFailure(failure.errorMessage));
    }, (showUnAvailableCategories) {
      emit(UnAvailableCategorySuccess(showUnAvailableCategories));
    },
    );
  }
}