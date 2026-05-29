import 'package:equatable/equatable.dart';
import '../../domain/entities/setting_user_entity.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class SettingInitial extends SettingState {
  const SettingInitial();
}

class SettingLoading extends SettingState {
  const SettingLoading();
}

class SettingLoaded extends SettingState {
  final SettingUserEntity user;
  final bool notificationEnabled;

  const SettingLoaded({
    required this.user,
    this.notificationEnabled = true,
  });

  @override
  List<Object?> get props => [user, notificationEnabled];

  SettingLoaded copyWith({
    SettingUserEntity? user,
    bool? notificationEnabled,
  }) {
    return SettingLoaded(
      user: user ?? this.user,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }
}

class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Emitted while an update operation is in progress (profile page save button).
class SettingUpdateLoading extends SettingState {
  final SettingUserEntity user;

  const SettingUpdateLoading({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Emitted when the update operation succeeds.
class SettingUpdateSuccess extends SettingState {
  final SettingUserEntity user;

  const SettingUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Emitted when the update operation fails.
class SettingUpdateError extends SettingState {
  final SettingUserEntity user;
  final String message;

  const SettingUpdateError({required this.user, required this.message});

  @override
  List<Object?> get props => [user, message];
}
