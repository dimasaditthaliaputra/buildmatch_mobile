import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the settings page is first loaded.
class LoadUserProfileEvent extends SettingEvent {
  const LoadUserProfileEvent();
}

/// Triggered when the user taps "Simpan Perubahan".
class UpdateUserProfileEvent extends SettingEvent {
  final String? fullName;
  final String? phoneNumber;
  final String? address;

  const UpdateUserProfileEvent({
    this.fullName,
    this.phoneNumber,
    this.address,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, address];
}

/// Triggered when the notification toggle is changed.
class ToggleNotificationEvent extends SettingEvent {
  final bool isEnabled;

  const ToggleNotificationEvent({required this.isEnabled});

  @override
  List<Object?> get props => [isEnabled];
}
