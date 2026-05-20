part of 'contractor_add_progres_bloc.dart';

abstract class ContractorAddProgresEvent extends Equatable {
  const ContractorAddProgresEvent();

  @override
  List<Object?> get props => [];
}

class TambahProgresInitialized extends ContractorAddProgresEvent {
  const TambahProgresInitialized();
}

class TambahProgresTabChanged extends ContractorAddProgresEvent {
  final InputMode mode;
  const TambahProgresTabChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

class TambahProgresJenisPekerjaanDipilih extends ContractorAddProgresEvent {
  final JenisPekerjaanEntity jenisPekerjaan;
  const TambahProgresJenisPekerjaanDipilih(this.jenisPekerjaan);

  @override
  List<Object?> get props => [jenisPekerjaan];
}

class TambahProgresJenisPekerjaanManualChanged extends ContractorAddProgresEvent {
  final String nilai;
  const TambahProgresJenisPekerjaanManualChanged(this.nilai);

  @override
  List<Object?> get props => [nilai];
}

class TambahProgresPersentaseDitambah extends ContractorAddProgresEvent {
  const TambahProgresPersentaseDitambah();
}

class TambahProgresPersentaseDikurangi extends ContractorAddProgresEvent {
  const TambahProgresPersentaseDikurangi();
}

class TambahProgresPersentaseDiubah extends ContractorAddProgresEvent {
  final double nilai;
  const TambahProgresPersentaseDiubah(this.nilai);

  @override
  List<Object> get props => [nilai];
}

/// Simpan progres
class TambahProgresDiSimpan extends ContractorAddProgresEvent {
  const TambahProgresDiSimpan();
}