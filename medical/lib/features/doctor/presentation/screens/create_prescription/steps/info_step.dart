import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constants/app_text_styles.dart';

class InfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController diagnosisController;
  final TextEditingController notesController;
  final DateTime startDate;
  final DateTime? endDate;
  final Function(DateTime, DateTime?) onDateChanged;

  const InfoStep({
    super.key,
    required this.formKey,
    required this.diagnosisController,
    required this.notesController,
    required this.startDate,
    this.endDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Prescription Information', style: AppTextStyles.h3),
          const SizedBox(height: 24),
          TextFormField(
            controller: diagnosisController,
            decoration: const InputDecoration(
              labelText: 'Diagnosis / Condition',
              hintText: 'e.g. Hypertension management',
              border: OutlineInputBorder(),
            ),
            validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'General Notes',
              hintText: 'Optional instructions or observations...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Duration', style: AppTextStyles.label),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.date_range),
            title: Text('Starts: ${DateFormat('MMM dd, yyyy').format(startDate)}'),
            subtitle: Text(endDate == null ? 'No end date (Chronic)' : 'Ends: ${DateFormat('MMM dd, yyyy').format(endDate!)}'),
            trailing: TextButton(
              onPressed: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDateRange: DateTimeRange(start: startDate, end: endDate ?? startDate.add(const Duration(days: 30))),
                );
                if (picked != null) {
                  onDateChanged(picked.start, picked.end);
                }
              },
              child: const Text('Change'),
            ),
          ),
        ],
      ),
    );
  }
}