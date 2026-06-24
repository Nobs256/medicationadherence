// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todaySchedulesHash() => r'63b7a6a9572b798ff52259c22ad77ec50f3c9e97';

/// See also [todaySchedules].
@ProviderFor(todaySchedules)
final todaySchedulesProvider =
    AutoDisposeFutureProvider<List<MedicationSchedule>>.internal(
      todaySchedules,
      name: r'todaySchedulesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$todaySchedulesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodaySchedulesRef =
    AutoDisposeFutureProviderRef<List<MedicationSchedule>>;
String _$adherenceSummaryHash() => r'5f7ddefeb8c78fb511f87a741b02af8fb5e592b1';

/// See also [adherenceSummary].
@ProviderFor(adherenceSummary)
final adherenceSummaryProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      adherenceSummary,
      name: r'adherenceSummaryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$adherenceSummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdherenceSummaryRef =
    AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$myPrescriptionsHash() => r'52f55d750e46602c466c8abe7589d7a919a2321f';

/// See also [myPrescriptions].
@ProviderFor(myPrescriptions)
final myPrescriptionsProvider =
    AutoDisposeFutureProvider<List<Prescription>>.internal(
      myPrescriptions,
      name: r'myPrescriptionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$myPrescriptionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPrescriptionsRef = AutoDisposeFutureProviderRef<List<Prescription>>;
String _$prescriptionDetailHash() =>
    r'f1b8130122d7f2483aaeedb0364b4c4a9fa31ef7';

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

/// See also [prescriptionDetail].
@ProviderFor(prescriptionDetail)
const prescriptionDetailProvider = PrescriptionDetailFamily();

/// See also [prescriptionDetail].
class PrescriptionDetailFamily extends Family<AsyncValue<Prescription>> {
  /// See also [prescriptionDetail].
  const PrescriptionDetailFamily();

  /// See also [prescriptionDetail].
  PrescriptionDetailProvider call(int id) {
    return PrescriptionDetailProvider(id);
  }

  @override
  PrescriptionDetailProvider getProviderOverride(
    covariant PrescriptionDetailProvider provider,
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
  String? get name => r'prescriptionDetailProvider';
}

/// See also [prescriptionDetail].
class PrescriptionDetailProvider
    extends AutoDisposeFutureProvider<Prescription> {
  /// See also [prescriptionDetail].
  PrescriptionDetailProvider(int id)
    : this._internal(
        (ref) => prescriptionDetail(ref as PrescriptionDetailRef, id),
        from: prescriptionDetailProvider,
        name: r'prescriptionDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$prescriptionDetailHash,
        dependencies: PrescriptionDetailFamily._dependencies,
        allTransitiveDependencies:
            PrescriptionDetailFamily._allTransitiveDependencies,
        id: id,
      );

  PrescriptionDetailProvider._internal(
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
    FutureOr<Prescription> Function(PrescriptionDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrescriptionDetailProvider._internal(
        (ref) => create(ref as PrescriptionDetailRef),
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
  AutoDisposeFutureProviderElement<Prescription> createElement() {
    return _PrescriptionDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrescriptionDetailProvider && other.id == id;
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
mixin PrescriptionDetailRef on AutoDisposeFutureProviderRef<Prescription> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PrescriptionDetailProviderElement
    extends AutoDisposeFutureProviderElement<Prescription>
    with PrescriptionDetailRef {
  _PrescriptionDetailProviderElement(super.provider);

  @override
  int get id => (origin as PrescriptionDetailProvider).id;
}

String _$patientAppointmentsHash() =>
    r'285008f8a7c6c2a68699bb5b777c543b101a92a8';

/// See also [patientAppointments].
@ProviderFor(patientAppointments)
final patientAppointmentsProvider =
    AutoDisposeFutureProvider<List<Appointment>>.internal(
      patientAppointments,
      name: r'patientAppointmentsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$patientAppointmentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientAppointmentsRef =
    AutoDisposeFutureProviderRef<List<Appointment>>;
String _$patientLifestyleAdviceHash() =>
    r'ee8f817eca9523be881a08e7c7d5aae3a50be053';

/// See also [patientLifestyleAdvice].
@ProviderFor(patientLifestyleAdvice)
final patientLifestyleAdviceProvider =
    AutoDisposeFutureProvider<List<Prescription>>.internal(
      patientLifestyleAdvice,
      name: r'patientLifestyleAdviceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$patientLifestyleAdviceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientLifestyleAdviceRef =
    AutoDisposeFutureProviderRef<List<Prescription>>;
String _$scheduleActionHash() => r'f44a5bd6d42997fb589ef81064de7499b99dc3b9';

/// See also [ScheduleAction].
@ProviderFor(ScheduleAction)
final scheduleActionProvider =
    AutoDisposeNotifierProvider<ScheduleAction, AsyncValue<void>>.internal(
      ScheduleAction.new,
      name: r'scheduleActionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$scheduleActionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScheduleAction = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
