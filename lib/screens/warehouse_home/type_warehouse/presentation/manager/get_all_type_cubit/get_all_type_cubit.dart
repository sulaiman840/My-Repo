import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/type_repo.dart';
import 'get_all_type_state.dart';

class GetAllTypeCubit extends Cubit<GetAllTypeState> {

  static GetAllTypeCubit get(context) => BlocProvider.of(context);

  GetAllTypeCubit(this.typeRepo) : super(GetAllTypeInitial());

  final TypeRepo typeRepo;

  Future<void> fetchAllTypes() async {
    emit(GetAllTypeLoading());
    var result = await typeRepo.fetchAllTypes();

    result.fold((failure) {
        emit(GetAllTypeFailure(failure.errorMessage));
      }, (showAllTypes) {
        emit(GetAllTypeSuccess(showAllTypes));
      },
    );
  }
}