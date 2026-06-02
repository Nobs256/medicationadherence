import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    String? phone,
    @JsonKey(name: 'role_name') required String roleName,
    @JsonKey(name: 'hospital_id') int? hospitalId,
    @JsonKey(name: 'hospital_name') String? hospitalName,
    @JsonKey(name: 'hospital_logo') String? hospitalLogo,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    String? gender,
    @JsonKey(name: 'emergency_contact') String? emergencyContact,
    String? diagnosis,
    @JsonKey(name: 'is_active', fromJson: _boolFromInt, toJson: _boolToInt)
    required bool isActive,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

bool _boolFromInt(dynamic val) => val == 1 || val == true;
int _boolToInt(bool val) => val ? 1 : 0;
