import 'package:equatable/equatable.dart';

abstract class WaitingApprovalEvent extends Equatable {
  const WaitingApprovalEvent();

  @override
  List<Object> get props => [];
}

class GetVerificationStatusEvent extends WaitingApprovalEvent {}
