import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {

  static DeleteCategoryCubit get(context) => BlocProvider.of(context);

  DeleteCategoryCubit(this.categoryRepo) : super(DeleteCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchDeleteCategory({
    required int id,
  }) async {
    emit(DeleteCategoryLoading());
    var result = await categoryRepo.fetchDeleteCategory(
      id: id,
    );

    result.fold((failure) {
      emit(DeleteCategoryFailure(failure.errorMessage));
    }, (deleteCategory) {
      emit(DeleteCategorySuccess(deleteCategory));
    },
    );
  }
}