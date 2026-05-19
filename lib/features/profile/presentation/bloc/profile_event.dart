import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class SubmitProfileEvent extends ProfileEvent {
  final ProfileEntity profile;

  const SubmitProfileEvent(this.profile);

  @override
  List<Object?> get props => [profile];
}
