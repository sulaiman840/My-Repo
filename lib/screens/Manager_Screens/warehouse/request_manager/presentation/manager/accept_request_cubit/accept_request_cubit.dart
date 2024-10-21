import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/request_repo.dart';
import 'accept_request_state.dart';

class AcceptRequestCubit extends Cubit<AcceptRequestState> {

  static AcceptRequestCubit get(context) => BlocProvider.of(context);

  AcceptRequestCubit(this.requestRepo) : super(AcceptRequestInitial());

  final RequestRepo requestRepo;

  Future<void> fetchAcceptRequest({
  required int id,
}) async {
    emit(AcceptRequestLoading());
    var result = await requestRepo.fetchAcceptRequest(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(AcceptRequestFailure(failure.errorMessage));
    }, (acceptResult) {
      emit(AcceptRequestSuccess(acceptResult));
    },
    );
  }
}