import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/hospital_provider.dart';

class ManagePatientsScreen extends ConsumerStatefulWidget {
  const ManagePatientsScreen({super.key});
  @override ConsumerState<ManagePatientsScreen> createState() => _ManagePatientsScreenState();
}

class _ManagePatientsScreenState extends ConsumerState<ManagePatientsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(hospitalPatientsProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Manage Patients'), backgroundColor: AppColors.background),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search patients...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border))),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
          ),
          Expanded(
            child: patientsAsync.when(
              data: (patients) {
                final filtered = patients.where((p) => p.fullName.toLowerCase().contains(_query)).toList();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final p = filtered[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
                      child: ListTile(
                        title: Text(p.fullName, style: AppTextStyles.h3.copyWith(fontSize: 16)),
                        subtitle: Text(p.diagnosis ?? 'General Checkup'),
                        trailing: IconButton(icon: const Icon(Icons.assignment_ind_outlined), onPressed: () => context.push('/admin/patients/${p.id}/assign')),
                      ),
                    );
                  },
                );
              },
              loading: () => LoadingShimmer.list(count: 6),
              error: (e, __) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/admin/patients/add'), backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}