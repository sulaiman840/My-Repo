import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'update_category_state.dart';

class UpdateCategoryCubit extends Cubit<UpdateCategoryState> {

  static UpdateCategoryCubit get(context) => BlocProvider.of(context);

  UpdateCategoryCubit(this.categoryRepo) : super(UpdateCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchUpdateCategory({
    required int id,
    required String name,
  }) async {
    emit(UpdateCategoryLoading());
    var result = await categoryRepo.fetchUpdateCategory(
      id: id,
      name: name,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateCategoryFailure(failure.errorMessage));
    }, (updateCategory) {
      emit(UpdateCategorySuccess(updateCategory));
    },
    );
  }
}