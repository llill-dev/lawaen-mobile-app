part of 'mune_cubit.dart';

class MuneState extends Equatable {
  final RequestState muneState;
  final MuneModel? mune;
  final String? muneError;
  final String? globalError;

  const MuneState({
    this.muneState = RequestState.idle,
    this.mune,
    this.muneError,
    this.globalError,
  });

  MuneState copyWith({
    RequestState? muneState,
    MuneModel? mune,
    String? muneError,
    String? globalError,
  }) {
    return MuneState(
      muneState: muneState ?? this.muneState,
      mune: mune ?? this.mune,
      muneError: muneError ?? this.muneError,
      globalError: globalError ?? this.globalError,
    );
  }

  @override
  List<Object?> get props => [muneState, mune, muneError, globalError];
}
