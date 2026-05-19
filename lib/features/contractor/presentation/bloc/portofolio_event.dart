part of 'portofolio_bloc.dart';

abstract class PortofolioEvent extends Equatable {
  const PortofolioEvent();

  @override
  List<Object?> get props => [];
}

class JudulChanged extends PortofolioEvent {
  final String value;
  const JudulChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class DeskripsiChanged extends PortofolioEvent {
  final String value;
  const DeskripsiChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class ImagesAdded extends PortofolioEvent {
  final List<String> paths;
  const ImagesAdded(this.paths);

  @override
  List<Object?> get props => [paths];
}

class ImageRemoved extends PortofolioEvent {
  final int index;
  const ImageRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class PortofolioSubmitted extends PortofolioEvent {
  const PortofolioSubmitted();
}

class PortofolioReset extends PortofolioEvent {
  const PortofolioReset();
}
