import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/type_repo.dart';
import 'create_type_state.dart';

class CreateTypeCubit extends Cubit<CreateTypeState> {

  static CreateTypeCubit get(context) => BlocProvider.of(context);

  CreateTypeCubit(this.typeRepo) : super(CreateTypeInitial());

  final TypeRepo typeRepo;

  Future<void> fetchCreateType({
    required String name,
  }) async {
    emit(CreateTypeLoading());
    var result = await typeRepo.fetchCreateType(
      name: name,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateTypeFailure(failure.errorMessage));
    }, (createType) {
      emit(CreateTypeSuccess(createType));
    },
    );
  }
}