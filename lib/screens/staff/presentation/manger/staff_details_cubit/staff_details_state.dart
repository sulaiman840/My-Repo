import 'package:equatable/equatable.dart';
import 'package:project2/screens/staff/data/models/show_staff_details_model.dart';

import '../../../data/models/show_all_staff_model.dart';

abstract class StaffDetailsState extends Equatable {
  const StaffDetailsState();

  @override
  List<Object> get props => [];
}

class StaffDetailsInitial extends StaffDetailsState {}
class StaffDetailsLoading extends StaffDetailsState {}
class StaffDetailsFailure extends StaffDetailsState {
  final String errorMessage;

  StaffDetailsFailure(this.errorMessage);
}
class StaffDetailsSuccess extends StaffDetailsState {
  final List<ShowStaffDetailsModel> staffDetails;

  StaffDetailsSuccess(this.staffDetails);
}