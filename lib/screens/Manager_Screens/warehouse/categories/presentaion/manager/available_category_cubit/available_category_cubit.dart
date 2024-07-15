import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'available_category_state.dart';

class AvailableCategoryCubit extends Cubit<AvailableCategoryState> {

  static AvailableCategoryCubit get(context) => BlocProvider.of(context);

  AvailableCategoryCubit(this.categoryRepo) : super(AvailableCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchAvailableCategories() async {
    emit(AvailableCategoryLoading());
    var result = await categoryRepo.fetchAvailableCategories();

    result.fold((failure) {
      emit(AvailableCategoryFailure(failure.errorMessage));
    }, (showAvailableCategories) {
      emit(AvailableCategorySuccess(showAvailableCategories));
    },
    );
  }
}