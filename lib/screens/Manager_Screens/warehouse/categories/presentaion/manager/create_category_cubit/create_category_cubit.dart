import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/repos/category_repo.dart';

import 'create_category_state.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {

  static CreateCategoryCubit get(context) => BlocProvider.of(context);

  CreateCategoryCubit(this.categoryRepo) : super(CreateCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchCreateCategory({
    required String name,
    required int parentId,
  }) async {
    emit(CreateCategoryLoading());
    var result = await categoryRepo.fetchCreateCategory(
      name: name,
      parentId: parentId,
    );

    result.fold((failure) {
      print(failure.errorMessage);
      emit(CreateCategoryFailure(failure.errorMessage));
    }, (createCategory) {
      emit(CreateCategorySuccess(createCategory));
    },
    );
  }
}