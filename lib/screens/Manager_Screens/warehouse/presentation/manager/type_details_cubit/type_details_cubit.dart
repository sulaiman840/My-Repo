import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/type_details_cubit/type_details_state.dart';

import '../../../data/repos/type_repo.dart';

class TypeDetailsCubit extends Cubit<TypeDetailsState> {

  static TypeDetailsCubit get(context) => BlocProvider.of(context);

  TypeDetailsCubit(super.initialState, this.typeRepo);

  final TypeRepo typeRepo;

  Future<void> fetchTypeById({
  required int id,
}) async {
    emit(TypeDetailsLoading());
    var result = await typeRepo.fetchTypeById(
      id: id,
    );

    result.fold((failure) {
      emit(TypeDetailsFailure(failure.errorMessage));
    }, (showType) {
      emit(TypeDetailsSuccess(showType));
    },
    );
  }
}