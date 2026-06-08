// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Medication _$MedicationFromJson(Map<String, dynamic> json) {
  return _Medication.fromJson(json);
}

/// @nodoc
mixin _$Medication {
  @JsonKey(fromJson: _intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic)
  int? get hospitalId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'generic_name')
  String? get genericName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by_name')
  String? get createdByName => throw _privateConstructorUsedError;

  /// Serializes this Medication to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationCopyWith<Medication> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationCopyWith<$Res> {
  factory $MedicationCopyWith(
    Medication value,
    $Res Function(Medication) then,
  ) = _$MedicationCopyWithImpl<$Res, Medication>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic) int? hospitalId,
    String name,
    @JsonKey(name: 'generic_name') String? genericName,
    String? description,
    String? category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_by_name') String? createdByName,
  });
}

/// @nodoc
class _$MedicationCopyWithImpl<$Res, $Val extends Medication>
    implements $MedicationCopyWith<$Res> {
  _$MedicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hospitalId = freezed,
    Object? name = null,
    Object? genericName = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? createdByName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            hospitalId:
                freezed == hospitalId
                    ? _value.hospitalId
                    : hospitalId // ignore: cast_nullable_to_non_nullable
                        as int?,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            genericName:
                freezed == genericName
                    ? _value.genericName
                    : genericName // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            category:
                freezed == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String?,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdByName:
                freezed == createdByName
                    ? _value.createdByName
                    : createdByName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MedicationImplCopyWith<$Res>
    implements $MedicationCopyWith<$Res> {
  factory _$$MedicationImplCopyWith(
    _$MedicationImpl value,
    $Res Function(_$MedicationImpl) then,
  ) = __$$MedicationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _intFromJson) int id,
    @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic) int? hospitalId,
    String name,
    @JsonKey(name: 'generic_name') String? genericName,
    String? description,
    String? category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_by_name') String? createdByName,
  });
}

/// @nodoc
class __$$MedicationImplCopyWithImpl<$Res>
    extends _$MedicationCopyWithImpl<$Res, _$MedicationImpl>
    implements _$$MedicationImplCopyWith<$Res> {
  __$$MedicationImplCopyWithImpl(
    _$MedicationImpl _value,
    $Res Function(_$MedicationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hospitalId = freezed,
    Object? name = null,
    Object? genericName = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? imageUrl = freezed,
    Object? createdByName = freezed,
  }) {
    return _then(
      _$MedicationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        hospitalId:
            freezed == hospitalId
                ? _value.hospitalId
                : hospitalId // ignore: cast_nullable_to_non_nullable
                    as int?,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        genericName:
            freezed == genericName
                ? _value.genericName
                : genericName // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        category:
            freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String?,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdByName:
            freezed == createdByName
                ? _value.createdByName
                : createdByName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationImpl implements _Medication {
  const _$MedicationImpl({
    @JsonKey(fromJson: _intFromJson) required this.id,
    @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic) this.hospitalId,
    required this.name,
    @JsonKey(name: 'generic_name') this.genericName,
    this.description,
    this.category,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'created_by_name') this.createdByName,
  });

  factory _$MedicationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationImplFromJson(json);

  @override
  @JsonKey(fromJson: _intFromJson)
  final int id;
  @override
  @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic)
  final int? hospitalId;
  @override
  final String name;
  @override
  @JsonKey(name: 'generic_name')
  final String? genericName;
  @override
  final String? description;
  @override
  final String? category;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'created_by_name')
  final String? createdByName;

  @override
  String toString() {
    return 'Medication(id: $id, hospitalId: $hospitalId, name: $name, genericName: $genericName, description: $description, category: $category, imageUrl: $imageUrl, createdByName: $createdByName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hospitalId, hospitalId) ||
                other.hospitalId == hospitalId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genericName, genericName) ||
                other.genericName == genericName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdByName, createdByName) ||
                other.createdByName == createdByName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    hospitalId,
    name,
    genericName,
    description,
    category,
    imageUrl,
    createdByName,
  );

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationImplCopyWith<_$MedicationImpl> get copyWith =>
      __$$MedicationImplCopyWithImpl<_$MedicationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationImplToJson(this);
  }
}

abstract class _Medication implements Medication {
  const factory _Medication({
    @JsonKey(fromJson: _intFromJson) required final int id,
    @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic)
    final int? hospitalId,
    required final String name,
    @JsonKey(name: 'generic_name') final String? genericName,
    final String? description,
    final String? category,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'created_by_name') final String? createdByName,
  }) = _$MedicationImpl;

  factory _Medication.fromJson(Map<String, dynamic> json) =
      _$MedicationImpl.fromJson;

  @override
  @JsonKey(fromJson: _intFromJson)
  int get id;
  @override
  @JsonKey(name: 'hospital_id', fromJson: _intFromDynamic)
  int? get hospitalId;
  @override
  String get name;
  @override
  @JsonKey(name: 'generic_name')
  String? get genericName;
  @override
  String? get description;
  @override
  String? get category;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'created_by_name')
  String? get createdByName;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationImplCopyWith<_$MedicationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
