part of 'update_profile_cubit_cubit.dart';

class UpdateProfileState extends Equatable {
  final RequestState updateState;
  final UserModel? user;
  final String? updateError;

  final RequestState changePasswordState;
  final String? changePasswordError;

  const UpdateProfileState({
    this.updateState = RequestState.idle,
    this.user,
    this.updateError,
    this.changePasswordState = RequestState.idle,
    this.changePasswordError,
  });

  UpdateProfileState copyWith({
    RequestState? updateState,
    UserModel? user,
    String? updateError,
    RequestState? changePasswordState,
    String? changePasswordError,
  }) {
    return UpdateProfileState(
      updateState: updateState ?? this.updateState,
      user: user ?? this.user,
      updateError: updateError,
      changePasswordState: changePasswordState ?? this.changePasswordState,
      changePasswordError: changePasswordError ?? this.changePasswordError,
    );
  }

  @override
  List<Object?> get props => [updateState, user, updateError, changePasswordState, changePasswordError];
}
