import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class HospitalAdmin {
  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String? phone;

  @JsonKey(name: 'is_active')
  final bool isActive;

  HospitalAdmin({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isActive,
    this.phone,
  });

  factory HospitalAdmin.fromJson(Map<String, dynamic> json) =>
      _$HospitalAdminFromJson(json);
}



