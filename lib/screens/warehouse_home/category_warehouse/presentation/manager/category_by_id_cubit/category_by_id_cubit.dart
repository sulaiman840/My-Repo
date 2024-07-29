import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'category_by_id_state.dart';

class CategoryByIdCubit extends Cubit<CategoryByIdState> {

  static CategoryByIdCubit get(context) => BlocProvider.of(context);

  CategoryByIdCubit(this.categoryRepo) : super(CategoryByIdInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchCategoryById({
  required int id,
}) async {
    emit(CategoryByIdLoading());
    var result = await categoryRepo.fetchCategoryById(
      id: id,
    );

    result.fold((failure) {
      emit(CategoryByIdFailure(failure.errorMessage));
    }, (showCategory) {
      emit(CategoryByIdSuccess(showCategory));
    },
    );
  }
}