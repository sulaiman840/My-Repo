import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'get_all_category_state.dart';

class GetAllCategoryCubit extends Cubit<GetAllCategoryState> {

  static GetAllCategoryCubit get(context) => BlocProvider.of(context);

  GetAllCategoryCubit(this.categoryRepo) : super(GetAllCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchAllCategories() async {
    emit(GetAllCategoryLoading());
    var result = await categoryRepo.fetchAllCategories();

    result.fold((failure) {
        emit(GetAllCategoryFailure(failure.errorMessage));
      }, (showAllCategories) {
        emit(GetAllCategorySuccess(showAllCategories));
      },
    );
  }
}