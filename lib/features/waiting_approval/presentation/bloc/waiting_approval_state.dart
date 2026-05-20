import 'package:equatable/equatable.dart';
import '../../domain/entities/verification_status.dart';

abstract class WaitingApprovalState extends Equatable {
  const WaitingApprovalState();
  
  @override
  List<Object?> get props => [];
}

class WaitingApprovalInitial extends WaitingApprovalState {}

class WaitingApprovalLoading extends WaitingApprovalState {}

class WaitingApprovalLoaded extends WaitingApprovalState {
  final VerificationStatus status;

  const WaitingApprovalLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

class WaitingApprovalError extends WaitingApprovalState {
  final String message;

  const WaitingApprovalError(this.message);

  @override
  List<Object?> get props => [message];
}
