import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/doctor_providers.dart';

class MyPatientsScreen extends ConsumerStatefulWidget {
  const MyPatientsScreen({super.key});

  @override
  ConsumerState<MyPatientsScreen> createState() => _MyPatientsScreenState();
}

class _MyPatientsScreenState extends ConsumerState<MyPatientsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(myPatientsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Patients', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (val) => setState(() => _query = val.toLowerCase()),
            ),
          ),
          Expanded(
            child: patientsAsync.when(
              data: (patients) {
                final filtered =
                    patients
                        .where(
                          (p) =>
                              p.fullName.toLowerCase().contains(_query) ||
                              (p.diagnosis?.toLowerCase().contains(_query) ??
                                  false),
                        )
                        .toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No patients found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final patient = filtered[index];
                    return _PatientCard(patient: patient);
                  },
                );
              },
              loading:
                  () => Padding(
                    padding: const EdgeInsets.all(16),
                    child: LoadingShimmer.list(count: 6),
                  ),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final dynamic patient;
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          backgroundImage:
              patient.avatarUrl != null
                  ? NetworkImage(patient.avatarUrl!)
                  : null,
          child:
              patient.avatarUrl == null
                  ? Text(
                    patient.fullName[0],
                    style: const TextStyle(color: AppColors.primary),
                  )
                  : null,
        ),
        title: Text(
          patient.fullName,
          style: AppTextStyles.h3.copyWith(fontSize: 16),
        ),
        subtitle: Text(
          patient.diagnosis ?? 'General Checkup',
          style: AppTextStyles.bodySm,
        ),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () => context.push('/doctor/patients/${patient.id}'),
      ),
    );
  }
}
