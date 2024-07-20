import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'reject_category_state.dart';

class RejectCategoryCubit extends Cubit<RejectCategoryState> {

  static RejectCategoryCubit get(context) => BlocProvider.of(context);

  RejectCategoryCubit(this.categoryRepo) : super(RejectCategoryInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchRejectCategory({
  required int id,
}) async {
    emit(RejectCategoryLoading());
    var result = await categoryRepo.fetchRejectCategory(id: id);

    result.fold((failure) {
      emit(RejectCategoryFailure(failure.errorMessage));
    }, (rejectResult) {
      emit(RejectCategorySuccess(rejectResult));
    },
    );
  }
}