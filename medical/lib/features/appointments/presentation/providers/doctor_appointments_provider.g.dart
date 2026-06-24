// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$doctorAppointmentsHash() =>
    r'ba109ce5877e7495c79e9f1a01b732e5496f3558';

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

/// Doctor-scoped appointments (backend filters by role via JWT).
///
/// Copied from [doctorAppointments].
@ProviderFor(doctorAppointments)
const doctorAppointmentsProvider = DoctorAppointmentsFamily();

/// Doctor-scoped appointments (backend filters by role via JWT).
///
/// Copied from [doctorAppointments].
class DoctorAppointmentsFamily extends Family<AsyncValue<List<Appointment>>> {
  /// Doctor-scoped appointments (backend filters by role via JWT).
  ///
  /// Copied from [doctorAppointments].
  const DoctorAppointmentsFamily();

  /// Doctor-scoped appointments (backend filters by role via JWT).
  ///
  /// Copied from [doctorAppointments].
  DoctorAppointmentsProvider call({String? status}) {
    return DoctorAppointmentsProvider(status: status);
  }

  @override
  DoctorAppointmentsProvider getProviderOverride(
    covariant DoctorAppointmentsProvider provider,
  ) {
    return call(status: provider.status);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'doctorAppointmentsProvider';
}

/// Doctor-scoped appointments (backend filters by role via JWT).
///
/// Copied from [doctorAppointments].
class DoctorAppointmentsProvider
    extends AutoDisposeFutureProvider<List<Appointment>> {
  /// Doctor-scoped appointments (backend filters by role via JWT).
  ///
  /// Copied from [doctorAppointments].
  DoctorAppointmentsProvider({String? status})
    : this._internal(
        (ref) =>
            doctorAppointments(ref as DoctorAppointmentsRef, status: status),
        from: doctorAppointmentsProvider,
        name: r'doctorAppointmentsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$doctorAppointmentsHash,
        dependencies: DoctorAppointmentsFamily._dependencies,
        allTransitiveDependencies:
            DoctorAppointmentsFamily._allTransitiveDependencies,
        status: status,
      );

  DoctorAppointmentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    FutureOr<List<Appointment>> Function(DoctorAppointmentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DoctorAppointmentsProvider._internal(
        (ref) => create(ref as DoctorAppointmentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Appointment>> createElement() {
    return _DoctorAppointmentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DoctorAppointmentsProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DoctorAppointmentsRef on AutoDisposeFutureProviderRef<List<Appointment>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _DoctorAppointmentsProviderElement
    extends AutoDisposeFutureProviderElement<List<Appointment>>
    with DoctorAppointmentsRef {
  _DoctorAppointmentsProviderElement(super.provider);

  @override
  String? get status => (origin as DoctorAppointmentsProvider).status;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
