import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/item_warehouse/data/repos/item_repo.dart';

import 'export_to_excel_state.dart';

class ExportToExcelCubit extends Cubit<ExportToExcelState> {

  static ExportToExcelCubit get(context) => BlocProvider.of(context);
  ExportToExcelCubit(this.itemRepo,) : super(ExportToExcelInitial());

  final ItemRepo itemRepo;

  Future<void> fetchExportToExcel({
    required List<String> fields,
  }) async {
    emit(ExportToExcelLoading());
    var result = await itemRepo.fetchExportToExcel(
      fields: fields,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ExportToExcelFailure(failure.errorMessage));
    }, (importResult) {
      emit(ExportToExcelSuccess(importResult));
    },
    );
  }
}