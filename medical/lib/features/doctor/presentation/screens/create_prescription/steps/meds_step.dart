import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../sharedwidgets/custom_button.dart';
import '../../../providers/doctor_providers.dart';
import '../../../../domain/models/medication.dart';

class MedsStep extends ConsumerWidget {
  final List<Map<String, dynamic>> meds;
  final Function(List<Map<String, dynamic>>) onUpdate;

  const MedsStep({super.key, required this.meds, required this.onUpdate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Medications', style: AppTextStyles.h3),
            TextButton.icon(
              onPressed: () => _showAddMedSheet(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Add Medication'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (meds.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text('No medications added yet.', style: AppTextStyles.bodySm)),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: meds.length,
            itemBuilder: (context, index) {
              final med = meds[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
                elevation: 0,
                child: ListTile(
                  title: Text(med['medication_name'], style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600)),
                  subtitle: Text('${med['dosage']} • ${med['frequency']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: AppColors.error),
                    onPressed: () {
                      final newList = List<Map<String, dynamic>>.from(meds);
                      newList.removeAt(index);
                      onUpdate(newList);
                    },
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  void _showAddMedSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _AddMedToPrescriptionSheet(
        onAdd: (newMed) {
          onUpdate([...meds, newMed]);
        },
      ),
    );
  }
}

class _AddMedToPrescriptionSheet extends ConsumerStatefulWidget {
  final Function(Map<String, dynamic>) onAdd;
  const _AddMedToPrescriptionSheet({required this.onAdd});

  @override
  ConsumerState<_AddMedToPrescriptionSheet> createState() => _AddMedToPrescriptionSheetState();
}

class _AddMedToPrescriptionSheetState extends ConsumerState<_AddMedToPrescriptionSheet> {
  Medication? _selectedLibMed;
  final _dosageController = TextEditingController();
  final _freqController = TextEditingController(text: 'once daily');
  final _instrController = TextEditingController();
  final List<String> _times = ['08:00'];
  bool _withFood = false;
  bool _withWater = true;

  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(medicationLibraryProvider());

    return Container(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Medication', style: AppTextStyles.h2),
            const SizedBox(height: 16),
            libraryAsync.when(
              data: (meds) => DropdownButtonFormField<Medication>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Select from library', border: OutlineInputBorder()),
                items: meds.map((m) => DropdownMenuItem(value: m, child: Text(m.name))).toList(),
                onChanged: (val) => setState(() => _selectedLibMed = val),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const Text('Error loading library'),
            ),
            if (_selectedLibMed != null) ...[
              const SizedBox(height: 16),
              TextField(controller: _dosageController, decoration: const InputDecoration(labelText: 'Dosage (e.g. 500mg)', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              TextField(controller: _freqController, decoration: const InputDecoration(labelText: 'Frequency (e.g. twice daily)', border: OutlineInputBorder())),
              const SizedBox(height: 16),
              SwitchListTile(title: const Text('Take with Food'), value: _withFood, onChanged: (v) => setState(() => _withFood = v)),
              SwitchListTile(title: const Text('Take with Water'), value: _withWater, onChanged: (v) => setState(() => _withWater = v)),
              const SizedBox(height: 16),
              TextField(controller: _instrController, decoration: const InputDecoration(labelText: 'Special Instructions (Optional)', border: OutlineInputBorder())),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Add Medication',
                onPressed: () {
                  if (_dosageController.text.isEmpty) return;
                  widget.onAdd({
                    'medication_id': _selectedLibMed!.id,
                    'medication_name': _selectedLibMed!.name,
                    'dosage': _dosageController.text,
                    'frequency': _freqController.text,
                    'times_of_day': _times,
                    'with_food': _withFood ? 1 : 0,
                    'with_water': _withWater ? 1 : 0,
                    'special_instructions': _instrController.text,
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}