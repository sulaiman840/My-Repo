import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/request_repo.dart';
import 'request_items_state.dart';

class RequestItemsCubit extends Cubit<RequestItemsState> {

  static RequestItemsCubit get(context) => BlocProvider.of(context);

  RequestItemsCubit(this.requestRepo) : super(RequestItemsInitial());

  final RequestRepo requestRepo;

  Future<void> fetchRequestItems() async {
    emit(RequestItemsLoading());
    var result = await requestRepo.fetchRequestItems();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(RequestItemsFailure(failure.errorMessage));
    }, (showRequestItems) {
      emit(RequestItemsSuccess(showRequestItems));
    },
    );
  }
}