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
String _$hospitalDoctorsHash() => r'54e836e6e7672b333753f5015e7d4f1a6efc729c';

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
String _$hospitalPatientsHash() => r'a6e6412e4fd6464c7619dbd224fe55885439a129';

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
String _$hospitalActionsHash() => r'63cb926da3f670eb4d4ea78a364bbf6bb14e14a5';

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
