// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$doctorStatsHash() => r'f682b75c4156bccab3979fe054af36018c72aa40';

/// See also [doctorStats].
@ProviderFor(doctorStats)
final doctorStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      doctorStats,
      name: r'doctorStatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$doctorStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DoctorStatsRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$myPatientsHash() => r'010b091d71f5843f8db36419ed98fb5ef0654a84';

/// See also [myPatients].
@ProviderFor(myPatients)
final myPatientsProvider =
    AutoDisposeFutureProvider<List<UserProfile>>.internal(
      myPatients,
      name: r'myPatientsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$myPatientsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPatientsRef = AutoDisposeFutureProviderRef<List<UserProfile>>;
String _$patientDetailHash() => r'56631b05a178aafe7ec5693c6043d8d0897a5c12';

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

/// See also [patientDetail].
@ProviderFor(patientDetail)
const patientDetailProvider = PatientDetailFamily();

/// See also [patientDetail].
class PatientDetailFamily extends Family<AsyncValue<UserProfile>> {
  /// See also [patientDetail].
  const PatientDetailFamily();

  /// See also [patientDetail].
  PatientDetailProvider call(int id) {
    return PatientDetailProvider(id);
  }

  @override
  PatientDetailProvider getProviderOverride(
    covariant PatientDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'patientDetailProvider';
}

/// See also [patientDetail].
class PatientDetailProvider extends AutoDisposeFutureProvider<UserProfile> {
  /// See also [patientDetail].
  PatientDetailProvider(int id)
    : this._internal(
        (ref) => patientDetail(ref as PatientDetailRef, id),
        from: patientDetailProvider,
        name: r'patientDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$patientDetailHash,
        dependencies: PatientDetailFamily._dependencies,
        allTransitiveDependencies:
            PatientDetailFamily._allTransitiveDependencies,
        id: id,
      );

  PatientDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<UserProfile> Function(PatientDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PatientDetailProvider._internal(
        (ref) => create(ref as PatientDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfile> createElement() {
    return _PatientDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientDetailRef on AutoDisposeFutureProviderRef<UserProfile> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PatientDetailProviderElement
    extends AutoDisposeFutureProviderElement<UserProfile>
    with PatientDetailRef {
  _PatientDetailProviderElement(super.provider);

  @override
  int get id => (origin as PatientDetailProvider).id;
}

String _$patientPrescriptionsHash() =>
    r'47a1188996cac041b5b85697c58358f093dd475e';

/// See also [patientPrescriptions].
@ProviderFor(patientPrescriptions)
const patientPrescriptionsProvider = PatientPrescriptionsFamily();

/// See also [patientPrescriptions].
class PatientPrescriptionsFamily
    extends Family<AsyncValue<List<Prescription>>> {
  /// See also [patientPrescriptions].
  const PatientPrescriptionsFamily();

  /// See also [patientPrescriptions].
  PatientPrescriptionsProvider call(int id) {
    return PatientPrescriptionsProvider(id);
  }

  @override
  PatientPrescriptionsProvider getProviderOverride(
    covariant PatientPrescriptionsProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'patientPrescriptionsProvider';
}

/// See also [patientPrescriptions].
class PatientPrescriptionsProvider
    extends AutoDisposeFutureProvider<List<Prescription>> {
  /// See also [patientPrescriptions].
  PatientPrescriptionsProvider(int id)
    : this._internal(
        (ref) => patientPrescriptions(ref as PatientPrescriptionsRef, id),
        from: patientPrescriptionsProvider,
        name: r'patientPrescriptionsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$patientPrescriptionsHash,
        dependencies: PatientPrescriptionsFamily._dependencies,
        allTransitiveDependencies:
            PatientPrescriptionsFamily._allTransitiveDependencies,
        id: id,
      );

  PatientPrescriptionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<List<Prescription>> Function(PatientPrescriptionsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PatientPrescriptionsProvider._internal(
        (ref) => create(ref as PatientPrescriptionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Prescription>> createElement() {
    return _PatientPrescriptionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientPrescriptionsRef
    on AutoDisposeFutureProviderRef<List<Prescription>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PatientPrescriptionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Prescription>>
    with PatientPrescriptionsRef {
  _PatientPrescriptionsProviderElement(super.provider);

  @override
  int get id => (origin as PatientPrescriptionsProvider).id;
}

String _$medicationLibraryHash() => r'b50edc8e58ac054722159bf9cce39b2f96a3aedb';

/// See also [medicationLibrary].
@ProviderFor(medicationLibrary)
const medicationLibraryProvider = MedicationLibraryFamily();

/// See also [medicationLibrary].
class MedicationLibraryFamily extends Family<AsyncValue<List<Medication>>> {
  /// See also [medicationLibrary].
  const MedicationLibraryFamily();

  /// See also [medicationLibrary].
  MedicationLibraryProvider call({String? query}) {
    return MedicationLibraryProvider(query: query);
  }

  @override
  MedicationLibraryProvider getProviderOverride(
    covariant MedicationLibraryProvider provider,
  ) {
    return call(query: provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'medicationLibraryProvider';
}

/// See also [medicationLibrary].
class MedicationLibraryProvider
    extends AutoDisposeFutureProvider<List<Medication>> {
  /// See also [medicationLibrary].
  MedicationLibraryProvider({String? query})
    : this._internal(
        (ref) => medicationLibrary(ref as MedicationLibraryRef, query: query),
        from: medicationLibraryProvider,
        name: r'medicationLibraryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$medicationLibraryHash,
        dependencies: MedicationLibraryFamily._dependencies,
        allTransitiveDependencies:
            MedicationLibraryFamily._allTransitiveDependencies,
        query: query,
      );

  MedicationLibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String? query;

  @override
  Override overrideWith(
    FutureOr<List<Medication>> Function(MedicationLibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MedicationLibraryProvider._internal(
        (ref) => create(ref as MedicationLibraryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Medication>> createElement() {
    return _MedicationLibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MedicationLibraryProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MedicationLibraryRef on AutoDisposeFutureProviderRef<List<Medication>> {
  /// The parameter `query` of this provider.
  String? get query;
}

class _MedicationLibraryProviderElement
    extends AutoDisposeFutureProviderElement<List<Medication>>
    with MedicationLibraryRef {
  _MedicationLibraryProviderElement(super.provider);

  @override
  String? get query => (origin as MedicationLibraryProvider).query;
}

String _$medicationActionsHash() => r'ddd51c745dcf24bbba648fc2a616a6522ffd3395';

/// See also [MedicationActions].
@ProviderFor(MedicationActions)
final medicationActionsProvider =
    AutoDisposeNotifierProvider<MedicationActions, AsyncValue<void>>.internal(
      MedicationActions.new,
      name: r'medicationActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$medicationActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MedicationActions = AutoDisposeNotifier<AsyncValue<void>>;
String _$prescriptionActionsHash() =>
    r'1b57ad1dc36849a0f94be465816f591472ced7ee';

/// See also [PrescriptionActions].
@ProviderFor(PrescriptionActions)
final prescriptionActionsProvider =
    AutoDisposeNotifierProvider<PrescriptionActions, AsyncValue<void>>.internal(
      PrescriptionActions.new,
      name: r'prescriptionActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$prescriptionActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrescriptionActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
