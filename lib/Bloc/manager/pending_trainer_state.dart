import 'package:equatable/equatable.dart';
import '../../models/Pending Model/pending_trainer.dart';


abstract class PendingTrainerState extends Equatable {
  const PendingTrainerState();

  @override
  List<Object> get props => [];
}

class PendingTrainerInitial extends PendingTrainerState {}

class PendingTrainerLoading extends PendingTrainerState {}

class PendingTrainerLoaded extends PendingTrainerState {
  final List<PendingTrainer> pendingTrainers;

  const PendingTrainerLoaded(this.pendingTrainers);

  @override
  List<Object> get props => [pendingTrainers];
}

class PendingTrainerError extends PendingTrainerState {
  final String message;

  const PendingTrainerError(this.message);

  @override
  List<Object> get props => [message];
}
