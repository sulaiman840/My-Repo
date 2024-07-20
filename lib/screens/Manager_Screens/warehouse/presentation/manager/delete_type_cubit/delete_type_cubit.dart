import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/type_repo.dart';
import 'delete_type_state.dart';

class DeleteTypeCubit extends Cubit<DeleteTypeState> {

  static DeleteTypeCubit get(context) => BlocProvider.of(context);

  DeleteTypeCubit(this.typeRepo) : super(DeleteTypeInitial());

  final TypeRepo typeRepo;

  Future<void> fetchDeleteType({
    required int id,
  }) async {
    emit(DeleteTypeLoading());
    var result = await typeRepo.fetchDeleteType(
      id: id,
    );

    result.fold((failure) {
      emit(DeleteTypeFailure(failure.errorMessage));
    }, (deleteType) {
      emit(DeleteTypeSuccess(deleteType));
    },
    );
  }
}