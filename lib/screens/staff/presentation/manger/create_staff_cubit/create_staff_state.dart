import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/create_staff_model.dart';

abstract class CreateStaffState extends Equatable {
  const CreateStaffState();

  @override
  List<Object> get props => [];
}

class CreateStaffInitial extends CreateStaffState {}
class CreateStaffLoading extends CreateStaffState {}
class CreateStaffFailure extends CreateStaffState {
  final String errorMessage;

  const CreateStaffFailure(this.errorMessage);
}
class CreateStaffSuccess extends CreateStaffState {
  final CreateStaffModel createResult;

  const CreateStaffSuccess(this.createResult);
}

class ImagePickedSuccess extends CreateStaffState {
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}

class ChangePassVisibilityState extends CreateStaffState {}