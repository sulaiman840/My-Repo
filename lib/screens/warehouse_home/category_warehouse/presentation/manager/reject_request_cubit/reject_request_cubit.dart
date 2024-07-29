import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/category_repo.dart';
import 'reject_request_state.dart';

class RejectRequestCubit extends Cubit<RejectRequestState> {

  static RejectRequestCubit get(context) => BlocProvider.of(context);

  RejectRequestCubit(this.categoryRepo) : super(RejectRequestInitial());

  final CategoryRepo categoryRepo;

  Future<void> fetchRejectRequest({
  required int id,
}) async {
    emit(RejectRequestLoading());
    var result = await categoryRepo.fetchRejectRequest(id: id);

    result.fold((failure) {
      emit(RejectRequestFailure(failure.errorMessage));
    }, (rejectResult) {
      emit(RejectRequestSuccess(rejectResult));
    },
    );
  }
}