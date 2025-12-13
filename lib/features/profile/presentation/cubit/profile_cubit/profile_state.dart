part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final RequestState contactUsState;
  final String? contactUsError;

  const ProfileState({this.contactUsState = RequestState.idle, this.contactUsError});

  ProfileState copyWith({RequestState? contactUsState, String? contactUsError}) {
    return ProfileState(
      contactUsState: contactUsState ?? this.contactUsState,
      contactUsError: contactUsError,
    );
  }

  @override
  List<Object?> get props => [contactUsState, contactUsError];
}
