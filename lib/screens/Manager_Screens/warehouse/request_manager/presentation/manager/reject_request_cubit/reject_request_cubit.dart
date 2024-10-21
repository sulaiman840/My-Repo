import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/request_repo.dart';
import 'reject_request_state.dart';

class RejectRequestCubit extends Cubit<RejectRequestState> {

  static RejectRequestCubit get(context) => BlocProvider.of(context);

  RejectRequestCubit(this.requestRepo) : super(RejectRequestInitial());

  final RequestRepo requestRepo;

  Future<void> fetchRejectRequest({
  required int id,
}) async {
    emit(RejectRequestLoading());
    var result = await requestRepo.fetchRejectRequest(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(RejectRequestFailure(failure.errorMessage));
    }, (rejectResult) {
      emit(RejectRequestSuccess(rejectResult));
    },
    );
  }
}