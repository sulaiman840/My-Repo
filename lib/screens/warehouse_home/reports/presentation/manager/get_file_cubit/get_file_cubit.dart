import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'get_file_state.dart';

class GetFileCubit extends Cubit<GetFileState> {

  static GetFileCubit get(context) => BlocProvider.of(context);

  GetFileCubit(this.reportRepo) : super(GetFileInitial());

  final ReportRepo reportRepo;

  Future<void> fetchFile({
    required int id,
    required String ext,
  }) async {
    emit(GetFileLoading());
    var result = await reportRepo.fetchFile(
      id: id,
      ext: ext,
    );

    result.fold((failure) {
      emit(GetFileFailure(failure.errorMessage));
    }, (file) {
      emit(GetFileSuccess(file));
    },
    );
  }
}