// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospitals_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$superAdminStatsHash() => r'8e0aa59e5ecc5bd5432aa58554f9cbe2cf528c3b';

/// See also [superAdminStats].
@ProviderFor(superAdminStats)
final superAdminStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      superAdminStats,
      name: r'superAdminStatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$superAdminStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SuperAdminStatsRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$hospitalsListHash() => r'd277a1b661936bb6cf957d064b8a528d2c8c763f';

/// See also [hospitalsList].
@ProviderFor(hospitalsList)
final hospitalsListProvider =
    AutoDisposeFutureProvider<List<Hospital>>.internal(
      hospitalsList,
      name: r'hospitalsListProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$hospitalsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HospitalsListRef = AutoDisposeFutureProviderRef<List<Hospital>>;
String _$hospitalDetailHash() => r'7904530860fff93172882263b24cb93bf37b5df5';

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

/// See also [hospitalDetail].
@ProviderFor(hospitalDetail)
const hospitalDetailProvider = HospitalDetailFamily();

/// See also [hospitalDetail].
class HospitalDetailFamily extends Family<AsyncValue<Hospital>> {
  /// See also [hospitalDetail].
  const HospitalDetailFamily();

  /// See also [hospitalDetail].
  HospitalDetailProvider call(int id) {
    return HospitalDetailProvider(id);
  }

  @override
  HospitalDetailProvider getProviderOverride(
    covariant HospitalDetailProvider provider,
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
  String? get name => r'hospitalDetailProvider';
}

/// See also [hospitalDetail].
class HospitalDetailProvider extends AutoDisposeFutureProvider<Hospital> {
  /// See also [hospitalDetail].
  HospitalDetailProvider(int id)
    : this._internal(
        (ref) => hospitalDetail(ref as HospitalDetailRef, id),
        from: hospitalDetailProvider,
        name: r'hospitalDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$hospitalDetailHash,
        dependencies: HospitalDetailFamily._dependencies,
        allTransitiveDependencies:
            HospitalDetailFamily._allTransitiveDependencies,
        id: id,
      );

  HospitalDetailProvider._internal(
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
    FutureOr<Hospital> Function(HospitalDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HospitalDetailProvider._internal(
        (ref) => create(ref as HospitalDetailRef),
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
  AutoDisposeFutureProviderElement<Hospital> createElement() {
    return _HospitalDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HospitalDetailProvider && other.id == id;
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
mixin HospitalDetailRef on AutoDisposeFutureProviderRef<Hospital> {
  /// The parameter `id` of this provider.
  int get id;
}

class _HospitalDetailProviderElement
    extends AutoDisposeFutureProviderElement<Hospital>
    with HospitalDetailRef {
  _HospitalDetailProviderElement(super.provider);

  @override
  int get id => (origin as HospitalDetailProvider).id;
}

String _$hospitalActionsHash() => r'49867d645b66ec0c3f9727684b9f1c128378b486';

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
