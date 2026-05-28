import 'package:equatable/equatable.dart';

abstract class InboxListEvent extends Equatable {
  const InboxListEvent();
  @override
  List<Object?> get props => [];
}

class LoadInboxRoomsEvent extends InboxListEvent {
  final String currentUserId;
  const LoadInboxRoomsEvent(this.currentUserId);
  @override
  List<Object?> get props => [currentUserId];
}
