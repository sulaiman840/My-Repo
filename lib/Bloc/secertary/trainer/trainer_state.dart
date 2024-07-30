import 'package:equatable/equatable.dart';
import '../../../models/Secertary Model/trainer_model.dart';

abstract class TrainerState extends Equatable {
  const TrainerState();

  @override
  List<Object?> get props => [];
}

class TrainerInitial extends TrainerState {}

class TrainerLoading extends TrainerState {}

class TrainerLoaded extends TrainerState {
  final List<Trainer> trainers;

  const TrainerLoaded(this.trainers);

  @override
  List<Object?> get props => [trainers];
}
class TrainerRegisteredInCourse extends TrainerState {}

class TrainerDetailLoaded extends TrainerState {
  final Trainer trainer;

  const TrainerDetailLoaded(this.trainer);

  @override
  List<Object?> get props => [trainer];
}

class TrainerError extends TrainerState {
  final String message;

  const TrainerError(this.message);

  @override
  List<Object?> get props => [message];
}