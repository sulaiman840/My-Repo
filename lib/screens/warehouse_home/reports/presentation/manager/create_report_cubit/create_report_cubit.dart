import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'create_report_state.dart';


class CreateReportCubit extends Cubit<CreateReportState> {

  static CreateReportCubit get(context) => BlocProvider.of(context);

  CreateReportCubit(this.reportRepo) : super(CreateReportInitial());

  final ReportRepo reportRepo;
  Uint8List? selectedFile;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png'],
          withData: true
      );

      if (result != null && result.files.single.bytes != null) {
        selectedFile = result.files.single.bytes!;
        emit(SelectFileSuccess());
      } else {
        log('No File selected or image data is unavailable.');
        emit(SelectFileFailure());
      }
    } catch (e) {
      log('Failed to pick File: $e');
      emit(SelectFileFailure());
    }
  }

  Future<void> fetchCreateReport({
    required String? title,
    required Uint8List? file,
    required String? body,
  }) async {
    emit(CreateReportLoading());
    var result = await reportRepo.fetchCreateReport(
      title: title,
      file: file,
      body: body,
    );

    result.fold((failure) {
      emit(CreateReportFailure(failure.errorMessage));
    }, (createReport) {
      emit(CreateReportSuccess(createReport));
    },
    );
  }
}