import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/status_badge.dart';
import '../providers/hospital_admins_provider.dart';

class ManageHospitalAdminsScreen extends ConsumerStatefulWidget {
  final int hospitalId;
  const ManageHospitalAdminsScreen({super.key, required this.hospitalId});

  @override
  ConsumerState<ManageHospitalAdminsScreen> createState() =>
      _ManageHospitalAdminsScreenState();
}

class _ManageHospitalAdminsScreenState
    extends ConsumerState<ManageHospitalAdminsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminsAsync = ref.watch(hospitalAdminsProvider(widget.hospitalId));
    final actionsState = ref.watch(hospitalAdminActionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hospital Admins'),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: adminsAsync.when(
              data: (admins) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: admins.length,
                  itemBuilder: (context, index) {
                    final a = admins[index];
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
                          child: Text(
                            a.fullName.isNotEmpty
                                ? a.fullName[0].toUpperCase()
                                : '?',
                          ),
                        ),
                        title: Text(
                          a.fullName,
                          style: AppTextStyles.h3.copyWith(fontSize: 16),
                        ),
                        subtitle: Text(a.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StatusBadge(
                              label: a.isActive ? 'ACTIVE' : 'INACTIVE',
                              color:
                                  a.isActive
                                      ? AppColors.success
                                      : AppColors.textMuted,
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              tooltip: a.isActive ? 'Deactivate' : 'Activate',
                              onPressed:
                                  () => ref
                                      .read(
                                        hospitalAdminActionsProvider.notifier,
                                      )
                                      .toggleAdmin(a.id, widget.hospitalId),
                              icon: Icon(
                                a.isActive ? Icons.toggle_on : Icons.toggle_off,
                                color:
                                    a.isActive
                                        ? AppColors.error
                                        : AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading:
                  () => Padding(
                    padding: const EdgeInsets.all(16),
                    child: LoadingShimmer.list(count: 8),
                  ),
              error: (e, __) => Center(child: Text('Error: $e')),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Register Hospital Admin', style: AppTextStyles.h3),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          actionsState.isLoading
                              ? null
                              : () async {
                                if (!_formKey.currentState!.validate()) return;
                                await ref
                                    .read(hospitalAdminActionsProvider.notifier)
                                    .createHospitalAdmin(
                                      hospitalId: widget.hospitalId,
                                      fullName: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      phone: _phoneController.text.trim(),
                                    );
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Hospital admin registered successfully',
                                      ),
                                    ),
                                  );
                                  _nameController.clear();
                                  _emailController.clear();
                                  _phoneController.clear();
                                }
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child:
                          actionsState.isLoading
                              ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text('Register Admin'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
