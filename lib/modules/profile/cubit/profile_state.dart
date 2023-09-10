part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == ProfileStatus.loading;
  bool get hasMessage =>
      this == ProfileStatus.success || this == ProfileStatus.failure;
}

final class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.statusMsg = '',
    this.editMode = false,
  });

  final ProfileStatus status;
  final String statusMsg;
  final bool editMode;

  @override
  List<Object> get props => [status, statusMsg, editMode];

  ProfileState copyWith({
    ProfileStatus? status,
    String? statusMsg,
    bool? editMode,
  }) {
    return ProfileState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      editMode: editMode ?? this.editMode,
    );
  }
}
