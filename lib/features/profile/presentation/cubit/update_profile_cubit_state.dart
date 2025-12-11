part of 'update_profile_cubit_cubit.dart';

class UpdateProfileState extends Equatable {
  final RequestState updateState;
  final UserModel? user;
  final String? updateError;

  const UpdateProfileState({this.updateState = RequestState.idle, this.user, this.updateError});

  UpdateProfileState copyWith({RequestState? updateState, UserModel? user, String? updateError}) {
    return UpdateProfileState(
      updateState: updateState ?? this.updateState,
      user: user ?? this.user,
      updateError: updateError,
    );
  }

  @override
  List<Object?> get props => [updateState, user, updateError];
}
