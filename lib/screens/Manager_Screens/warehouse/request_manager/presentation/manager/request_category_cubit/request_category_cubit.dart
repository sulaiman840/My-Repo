import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/request_repo.dart';
import 'request_category_state.dart';

class RequestCategoryCubit extends Cubit<RequestCategoryState> {

  static RequestCategoryCubit get(context) => BlocProvider.of(context);

  RequestCategoryCubit(this.requestRepo) : super(RequestCategoryInitial());

  final RequestRepo requestRepo;

  Future<void> fetchRequestCategories() async {
    emit(RequestCategoryLoading());
    var result = await requestRepo.fetchRequestCategories();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(RequestCategoryFailure(failure.errorMessage));
    }, (showRequestCategories) {
      emit(RequestCategorySuccess(showRequestCategories));
    },
    );
  }
}