// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminStatsHash() => r'8c911a53aa1c9e057afb40f70cfe140edabca8a6';

/// See also [adminStats].
@ProviderFor(adminStats)
final adminStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      adminStats,
      name: r'adminStatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$adminStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdminStatsRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$hospitalDoctorsHash() => r'5e509312ff848f5c99cc466e22d68b44f9ad97da';

/// See also [hospitalDoctors].
@ProviderFor(hospitalDoctors)
final hospitalDoctorsProvider =
    AutoDisposeFutureProvider<List<UserProfile>>.internal(
      hospitalDoctors,
      name: r'hospitalDoctorsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$hospitalDoctorsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HospitalDoctorsRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$hospitalPatientsHash() => r'5cc8bb13274bb998dcba54311dbb9df2ab2bd829';

/// See also [hospitalPatients].
@ProviderFor(hospitalPatients)
final hospitalPatientsProvider =
    AutoDisposeFutureProvider<List<UserProfile>>.internal(
      hospitalPatients,
      name: r'hospitalPatientsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$hospitalPatientsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HospitalPatientsRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$doctorAssignedPatientsHash() =>
    r'e14c44496c703833026200c1e208e39e884d6629';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [doctorAssignedPatients].
@ProviderFor(doctorAssignedPatients)
const doctorAssignedPatientsProvider = DoctorAssignedPatientsFamily();

/// See also [doctorAssignedPatients].
class DoctorAssignedPatientsFamily
    extends Family<AsyncValue<List<UserProfile>>> {
  /// See also [doctorAssignedPatients].
  const DoctorAssignedPatientsFamily();

  /// See also [doctorAssignedPatients].
  DoctorAssignedPatientsProvider call(int doctorId) {
    return DoctorAssignedPatientsProvider(doctorId);
  }

  @override
  DoctorAssignedPatientsProvider getProviderOverride(
    covariant DoctorAssignedPatientsProvider provider,
  ) {
    return call(provider.doctorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'doctorAssignedPatientsProvider';
}

/// See also [doctorAssignedPatients].
class DoctorAssignedPatientsProvider
    extends AutoDisposeFutureProvider<List<UserProfile>> {
  /// See also [doctorAssignedPatients].
  DoctorAssignedPatientsProvider(int doctorId)
    : this._internal(
        (ref) =>
            doctorAssignedPatients(ref as DoctorAssignedPatientsRef, doctorId),
        from: doctorAssignedPatientsProvider,
        name: r'doctorAssignedPatientsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$doctorAssignedPatientsHash,
        dependencies: DoctorAssignedPatientsFamily._dependencies,
        allTransitiveDependencies:
            DoctorAssignedPatientsFamily._allTransitiveDependencies,
        doctorId: doctorId,
      );

  DoctorAssignedPatientsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.doctorId,
  }) : super.internal();

  final int doctorId;

  @override
  Override overrideWith(
    FutureOr<List<UserProfile>> Function(DoctorAssignedPatientsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DoctorAssignedPatientsProvider._internal(
        (ref) => create(ref as DoctorAssignedPatientsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        doctorId: doctorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserProfile>> createElement() {
    return _DoctorAssignedPatientsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DoctorAssignedPatientsProvider &&
        other.doctorId == doctorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, doctorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DoctorAssignedPatientsRef
    on AutoDisposeFutureProviderRef<List<UserProfile>> {
  /// The parameter `doctorId` of this provider.
  int get doctorId;
}

class _DoctorAssignedPatientsProviderElement
    extends AutoDisposeFutureProviderElement<List<UserProfile>>
    with DoctorAssignedPatientsRef {
  _DoctorAssignedPatientsProviderElement(super.provider);

  @override
  int get doctorId => (origin as DoctorAssignedPatientsProvider).doctorId;
}

String _$hospitalActionsHash() => r'2dbb86f445468c959abaa3dd6e235cc794d009ed';

/// See also [HospitalActions].
@ProviderFor(HospitalActions)
final hospitalActionsProvider =
    AutoDisposeNotifierProvider<HospitalActions, AsyncValue<void>>.internal(
      HospitalActions.new,
      name: r'hospitalActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$hospitalActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HospitalActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
