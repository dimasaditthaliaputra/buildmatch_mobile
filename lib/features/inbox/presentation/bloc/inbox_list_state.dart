import 'package:equatable/equatable.dart';
import '../../domain/entities/consultation_room_entity.dart';

abstract class InboxListState extends Equatable {
  const InboxListState();
  @override
  List<Object?> get props => [];
}

class InboxListInitial extends InboxListState {}

class InboxListLoading extends InboxListState {}

class InboxListLoaded extends InboxListState {
  final List<ConsultationRoomEntity> rooms;
  const InboxListLoaded(this.rooms);
  @override
  List<Object?> get props => [rooms];
}

class InboxListError extends InboxListState {
  final String message;
  const InboxListError(this.message);
  @override
  List<Object?> get props => [message];
}
