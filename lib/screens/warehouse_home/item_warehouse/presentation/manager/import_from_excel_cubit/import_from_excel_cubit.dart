import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/item_repo.dart';
import 'import_from_excel_state.dart';

class ImportFromExcelCubit extends Cubit<ImportFromExcelState> {

  static ImportFromExcelCubit get(context) => BlocProvider.of(context);
  ImportFromExcelCubit(this.itemRepo,) : super(ImportFromExcelInitial());

  final ItemRepo itemRepo;
  Uint8List? selectedImage;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xls', 'xlsx'],
          withData: true
      );

      if (result != null && result.files.single.bytes != null) {
        selectedImage = result.files.single.bytes!;
        emit(SelectedFileSuccess());
      } else {
        log('No image selected or image data is unavailable.');
        emit(SelectedFileFailure());
      }
    } catch (e) {
      log('Failed to pick image: $e');
      emit(SelectedFileFailure());
    }
  }

  /*void register() {
      fetchImportFromExcel(
        excelFile: selectedImage!,
      );
    } else {
      emit(SelectedFileEmpty());
    }
  }*/

  Future<void> fetchImportFromExcel({
    required Uint8List excelFile,
  }) async {
    emit(ImportFromExcelLoading());
    var result = await itemRepo.fetchImportFromExcel(
      excelFile: excelFile,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ImportFromExcelFailure(failure.errorMessage));
    }, (importResult) {
      emit(ImportFromExcelSuccess(importResult));
    },
    );
  }
}
