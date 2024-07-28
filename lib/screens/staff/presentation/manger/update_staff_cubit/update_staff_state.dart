import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/update_staff_model.dart';

abstract class UpdateStaffState extends Equatable {
  const UpdateStaffState();

  @override
  List<Object> get props => [];
}

class UpdateStaffInitial extends UpdateStaffState {}
class UpdateStaffLoading extends UpdateStaffState {}
class UpdateStaffFailure extends UpdateStaffState {
  final String errorMessage;

  const UpdateStaffFailure(this.errorMessage);
}
class UpdateStaffSuccess extends UpdateStaffState {
  final UpdateStaffModel createResult;

  const UpdateStaffSuccess(this.createResult);
}

class ImagePickedSuccess extends UpdateStaffState {
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}

class ChangePassVisibilityState extends UpdateStaffState {}