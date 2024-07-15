import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/type_repo.dart';
import 'type_details_state.dart';

class TypeDetailsCubit extends Cubit<TypeDetailsState> {

  static TypeDetailsCubit get(context) => BlocProvider.of(context);

  TypeDetailsCubit(this.typeRepo) : super(TypeDetailsInitial());

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