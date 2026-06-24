// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_admins_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hospitalAdminsHash() => r'95e4ab60a1b129ab91cf8181c8c6474bcdcbc48b';

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

/// See also [hospitalAdmins].
@ProviderFor(hospitalAdmins)
const hospitalAdminsProvider = HospitalAdminsFamily();

/// See also [hospitalAdmins].
class HospitalAdminsFamily extends Family<AsyncValue<List<HospitalAdmin>>> {
  /// See also [hospitalAdmins].
  const HospitalAdminsFamily();

  /// See also [hospitalAdmins].
  HospitalAdminsProvider call(int hospitalId) {
    return HospitalAdminsProvider(hospitalId);
  }

  @override
  HospitalAdminsProvider getProviderOverride(
    covariant HospitalAdminsProvider provider,
  ) {
    return call(provider.hospitalId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hospitalAdminsProvider';
}

/// See also [hospitalAdmins].
class HospitalAdminsProvider
    extends AutoDisposeFutureProvider<List<HospitalAdmin>> {
  /// See also [hospitalAdmins].
  HospitalAdminsProvider(int hospitalId)
    : this._internal(
        (ref) => hospitalAdmins(ref as HospitalAdminsRef, hospitalId),
        from: hospitalAdminsProvider,
        name: r'hospitalAdminsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$hospitalAdminsHash,
        dependencies: HospitalAdminsFamily._dependencies,
        allTransitiveDependencies:
            HospitalAdminsFamily._allTransitiveDependencies,
        hospitalId: hospitalId,
      );

  HospitalAdminsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hospitalId,
  }) : super.internal();

  final int hospitalId;

  @override
  Override overrideWith(
    FutureOr<List<HospitalAdmin>> Function(HospitalAdminsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HospitalAdminsProvider._internal(
        (ref) => create(ref as HospitalAdminsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hospitalId: hospitalId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<HospitalAdmin>> createElement() {
    return _HospitalAdminsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HospitalAdminsProvider && other.hospitalId == hospitalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hospitalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HospitalAdminsRef on AutoDisposeFutureProviderRef<List<HospitalAdmin>> {
  /// The parameter `hospitalId` of this provider.
  int get hospitalId;
}

class _HospitalAdminsProviderElement
    extends AutoDisposeFutureProviderElement<List<HospitalAdmin>>
    with HospitalAdminsRef {
  _HospitalAdminsProviderElement(super.provider);

  @override
  int get hospitalId => (origin as HospitalAdminsProvider).hospitalId;
}

String _$hospitalAdminActionsHash() =>
    r'51523e0325df5f3995c7e55ce6310bdf30899910';

/// See also [HospitalAdminActions].
@ProviderFor(HospitalAdminActions)
final hospitalAdminActionsProvider = AutoDisposeNotifierProvider<
  HospitalAdminActions,
  AsyncValue<void>
>.internal(
  HospitalAdminActions.new,
  name: r'hospitalAdminActionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$hospitalAdminActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HospitalAdminActions = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
