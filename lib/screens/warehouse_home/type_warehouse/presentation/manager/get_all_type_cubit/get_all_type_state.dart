import 'package:equatable/equatable.dart';

import '../../../data/models/get_all_type_model.dart';

abstract class GetAllTypeState  extends Equatable {
  const GetAllTypeState();

  @override
  List<Object> get props => [];
}

class GetAllTypeInitial extends GetAllTypeState {}
class GetAllTypeLoading extends GetAllTypeState {}
class GetAllTypeFailure extends GetAllTypeState {
  final String errorMessage;

  const GetAllTypeFailure(this.errorMessage);
}
class GetAllTypeSuccess extends GetAllTypeState {
  final List<GetAllTypeModel> allTypes;

  const GetAllTypeSuccess(this.allTypes);
}