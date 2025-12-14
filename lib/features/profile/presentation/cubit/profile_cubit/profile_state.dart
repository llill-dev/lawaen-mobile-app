part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final RequestState contactUsState;
  final String? contactUsError;

  final RequestState getProfilePagesState;
  final List<ProfilePagesModel> getProfilePages;
  final String? getProfilePagesError;

  final RequestState getProfilePageState;
  final ProfilePageModel? getProfilePage;
  final String? getProfilePageError;

  const ProfileState({
    this.contactUsState = RequestState.idle,
    this.contactUsError,
    this.getProfilePagesState = RequestState.idle,
    this.getProfilePages = const [],
    this.getProfilePagesError,
    this.getProfilePageState = RequestState.idle,
    this.getProfilePage,
    this.getProfilePageError,
  });

  ProfileState copyWith({
    RequestState? contactUsState,
    String? contactUsError,
    RequestState? getProfilePagesState,
    List<ProfilePagesModel>? getProfilePages,
    String? getProfilePagesError,
    RequestState? getProfilePageState,
    ProfilePageModel? getProfilePage,
    String? getProfilePageError,
  }) {
    return ProfileState(
      contactUsState: contactUsState ?? this.contactUsState,
      contactUsError: contactUsError ?? this.contactUsError,
      getProfilePagesState: getProfilePagesState ?? this.getProfilePagesState,
      getProfilePages: getProfilePages ?? this.getProfilePages,
      getProfilePagesError: getProfilePagesError ?? this.getProfilePagesError,
      getProfilePageState: getProfilePageState ?? this.getProfilePageState,
      getProfilePage: getProfilePage ?? this.getProfilePage,
      getProfilePageError: getProfilePageError ?? this.getProfilePageError,
    );
  }

  @override
  List<Object?> get props => [
    contactUsState,
    contactUsError,
    getProfilePagesState,
    getProfilePages,
    getProfilePagesError,
    getProfilePageState,
    getProfilePage,
    getProfilePageError,
  ];
}
