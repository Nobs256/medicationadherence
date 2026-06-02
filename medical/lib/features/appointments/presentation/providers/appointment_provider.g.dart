// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentsHash() => r'0dd4d0bee888d7cfb95ab7820368a2a3511c38e4';

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

/// See also [appointments].
@ProviderFor(appointments)
const appointmentsProvider = AppointmentsFamily();

/// See also [appointments].
class AppointmentsFamily extends Family<AsyncValue<List<Appointment>>> {
  /// See also [appointments].
  const AppointmentsFamily();

  /// See also [appointments].
  AppointmentsProvider call({String? status}) {
    return AppointmentsProvider(status: status);
  }

  @override
  AppointmentsProvider getProviderOverride(
    covariant AppointmentsProvider provider,
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
  String? get name => r'appointmentsProvider';
}

/// See also [appointments].
class AppointmentsProvider
    extends AutoDisposeFutureProvider<List<Appointment>> {
  /// See also [appointments].
  AppointmentsProvider({String? status})
    : this._internal(
        (ref) => appointments(ref as AppointmentsRef, status: status),
        from: appointmentsProvider,
        name: r'appointmentsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$appointmentsHash,
        dependencies: AppointmentsFamily._dependencies,
        allTransitiveDependencies:
            AppointmentsFamily._allTransitiveDependencies,
        status: status,
      );

  AppointmentsProvider._internal(
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
    FutureOr<List<Appointment>> Function(AppointmentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppointmentsProvider._internal(
        (ref) => create(ref as AppointmentsRef),
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
    return _AppointmentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentsProvider && other.status == status;
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
mixin AppointmentsRef on AutoDisposeFutureProviderRef<List<Appointment>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _AppointmentsProviderElement
    extends AutoDisposeFutureProviderElement<List<Appointment>>
    with AppointmentsRef {
  _AppointmentsProviderElement(super.provider);

  @override
  String? get status => (origin as AppointmentsProvider).status;
}

String _$appointmentActionsHash() =>
    r'dcd9cb243a42c918dd1145a95a1d219554243bf9';

/// See also [AppointmentActions].
@ProviderFor(AppointmentActions)
final appointmentActionsProvider =
    AutoDisposeNotifierProvider<AppointmentActions, AsyncValue<void>>.internal(
      AppointmentActions.new,
      name: r'appointmentActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$appointmentActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppointmentActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
