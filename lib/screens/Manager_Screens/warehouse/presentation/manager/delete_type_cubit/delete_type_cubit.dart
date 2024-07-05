import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/delete_type_cubit/delete_type_state.dart';

import '../../../data/repos/type_repo.dart';

class DeleteTypeCubit extends Cubit<DeleteTypeState> {

  static DeleteTypeCubit get(context) => BlocProvider.of(context);

  DeleteTypeCubit(super.initialState, this.typeRepo);

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