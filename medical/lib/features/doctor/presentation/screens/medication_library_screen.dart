import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/loading_shimmer.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/doctor_providers.dart';
import '../../domain/models/medication.dart';

class MedicationLibraryScreen extends ConsumerStatefulWidget {
  const MedicationLibraryScreen({super.key});

  @override
  ConsumerState<MedicationLibraryScreen> createState() =>
      _MedicationLibraryScreenState();
}

class _MedicationLibraryScreenState
    extends ConsumerState<MedicationLibraryScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddMedicationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _AddMedicationSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicationsAsync = ref.watch(
      medicationLibraryProvider(query: _query),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Medication Library', style: AppTextStyles.h2),
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
                hintText: 'Search medication...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (val) => setState(() => _query = val),
            ),
          ),
          Expanded(
            child: medicationsAsync.when(
              data:
                  (meds) =>
                      meds.isEmpty
                          ? const Center(child: Text('No medications found.'))
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: meds.length,
                            itemBuilder:
                                (context, index) =>
                                    _MedicationCard(med: meds[index]),
                          ),
              loading:
                  () => Padding(
                    padding: const EdgeInsets.all(16),
                    child: LoadingShimmer.list(count: 8),
                  ),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicationSheet,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Medication med;
  const _MedicationCard({required this.med});

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
        title: Text(med.name, style: AppTextStyles.h3.copyWith(fontSize: 16)),
        subtitle: Text(
          med.genericName ?? med.category ?? 'General Medication',
          style: AppTextStyles.bodySm,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.medication, color: AppColors.primary),
        ),
      ),
    );
  }
}

class _AddMedicationSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AddMedicationSheet> createState() =>
      _AddMedicationSheetState();
}

class _AddMedicationSheetState extends ConsumerState<_AddMedicationSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _genericController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(medicationActionsProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Medication', style: AppTextStyles.h2),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medication Name'),
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _genericController,
              decoration: const InputDecoration(labelText: 'Generic Name'),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Save Medication',
              isLoading: actionState.isLoading,
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                await ref
                    .read(medicationActionsProvider.notifier)
                    .addMedication({
                      'name': _nameController.text,
                      'generic_name': _genericController.text,
                    });
                if (mounted) Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
