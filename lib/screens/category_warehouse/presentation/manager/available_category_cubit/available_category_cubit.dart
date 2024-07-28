import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'available_category_state.dart';

class RequestCategoryCubit extends Cubit<RequestCategoryState> {

  static RequestCategoryCubit get(context) => BlocProvider.of(context);

  RequestCategoryCubit(this.categoryRepo) : super(RequestCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchRequestCategories() async {
    emit(RequestCategoryLoading());
    var result = await categoryRepo.fetchRequestCategories();

    result.fold((failure) {
      emit(RequestCategoryFailure(failure.errorMessage));
    }, (showRequestCategories) {
      emit(RequestCategorySuccess(showRequestCategories));
    },
    );
  }
}