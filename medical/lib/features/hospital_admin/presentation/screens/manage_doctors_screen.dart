import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../providers/hospital_provider.dart';

class ManageDoctorsScreen extends ConsumerStatefulWidget {
  const ManageDoctorsScreen({super.key});
  @override
  ConsumerState<ManageDoctorsScreen> createState() =>
      _ManageDoctorsScreenState();
}

class _ManageDoctorsScreenState extends ConsumerState<ManageDoctorsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(hospitalDoctorsProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manage Doctors'),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
          ),
          Expanded(
            child: doctorsAsync.when(
              data: (doctors) {
                final filtered =
                    doctors
                        .where((d) => d.fullName.toLowerCase().contains(_query))
                        .toList();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final doc = filtered[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: Opacity(
                        opacity: doc.isActive ? 1.0 : 0.6,
                        child: ListTile(
                          onTap: () {
                            context.push('/admin/doctors/${doc.id}');
                          },
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              doc.fullName.isNotEmpty
                                  ? doc.fullName[0].toUpperCase()
                                  : '?',
                            ),
                          ),
                          title: Text(
                            doc.fullName,
                            style: AppTextStyles.h3.copyWith(fontSize: 16),
                          ),
                          subtitle: Text(doc.email),
                          trailing: Switch(
                            value: doc.isActive,
                            onChanged:
                                (_) => ref
                                    .read(hospitalActionsProvider.notifier)
                                    .toggleUserActive(doc.id)
                                    .then(
                                      (_) => ref.invalidate(
                                        hospitalDoctorsProvider,
                                      ),
                                    ),
                          ),
                        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/admin/doctors/add'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
