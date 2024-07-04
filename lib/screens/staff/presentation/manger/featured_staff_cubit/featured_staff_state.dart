import 'package:equatable/equatable.dart';

import '../../../data/models/show_all_staff_model.dart';

abstract class FeaturedStaffState extends Equatable {
  const FeaturedStaffState();

  @override
  List<Object> get props => [];
}

class FeaturedStaffInitial extends FeaturedStaffState {}
class FeaturedStaffLoading extends FeaturedStaffState {}
class FeaturedStaffFailure extends FeaturedStaffState {
  final String errorMessage;

  const FeaturedStaffFailure(this.errorMessage);
}
class FeaturedStaffSuccess extends FeaturedStaffState {
  final List<ShowAllStaffModel> allStaff;

  FeaturedStaffSuccess(this.allStaff);
}