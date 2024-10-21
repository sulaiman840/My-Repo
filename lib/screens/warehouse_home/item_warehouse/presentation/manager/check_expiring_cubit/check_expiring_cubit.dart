import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'check_expiring_state.dart';

class CheckExpiringCubit extends Cubit<CheckExpiringState> {

  static CheckExpiringCubit get(context) => BlocProvider.of(context);

  CheckExpiringCubit(this.itemRepo) : super(CheckExpiringInitial());

  final ItemRepo itemRepo;

  Future<void> fetchCheckExpiring() async {
    emit(CheckExpiringLoading());
    var result = await itemRepo.fetchCheckExpiring();

    result.fold((failure) {
      emit(CheckExpiringFailure(failure.errorMessage));
    }, (checkResult) {
      emit(CheckExpiringSuccess(checkResult));
    },
    );
  }
}