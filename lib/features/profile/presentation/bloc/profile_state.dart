import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSubmitting extends ProfileState {}

class ProfileSubmitSuccess extends ProfileState {}

class ProfileSubmitFailure extends ProfileState {
  final String errorMessage;

  const ProfileSubmitFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
