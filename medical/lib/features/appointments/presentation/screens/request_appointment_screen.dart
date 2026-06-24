import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../auth/domain/models/user_profile.dart';
import '../../../../core/services/api_service.dart';
import '../providers/appointment_provider.dart';

// A new provider to fetch doctors in the patient's hospital.
final hospitalDoctorsProvider = FutureProvider<List<UserProfile>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  // Assumes the API endpoint /users?role=doctor returns a list of doctors
  // in the same hospital as the authenticated patient.
  final response = await api.get('/users', params: {'role': 'doctor'});
  final List<dynamic> data = response['data'] ?? [];
  return data
      .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
      .toList();
});

class RequestAppointmentScreen extends ConsumerStatefulWidget {
  const RequestAppointmentScreen({super.key});

  @override
  ConsumerState<RequestAppointmentScreen> createState() =>
      _RequestAppointmentScreenState();
}

class _RequestAppointmentScreenState
    extends ConsumerState<RequestAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  UserProfile? _selectedDoctor;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  final _purposeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(hospitalDoctorsProvider);
    final actionState = ref.watch(appointmentActionsProvider);

    ref.listen<AsyncValue<void>>(appointmentActionsProvider, (_, state) {
      if (state.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
      }
      if (!state.isLoading && !state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment request sent!')),
        );
        if (mounted) context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Request Appointment'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Doctor', style: AppTextStyles.label),
              const SizedBox(height: 8),
              doctorsAsync.when(
                data:
                    (doctors) => DropdownButtonFormField<UserProfile>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Doctor',
                      ),
                      items:
                          doctors
                              .map(
                                (d) => DropdownMenuItem(
                                  value: d,
                                  child: Text(d.fullName),
                                ),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => _selectedDoctor = val),
                      validator: (v) => v == null ? 'Required' : null,
                    ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Error loading doctors'),
              ),
              const SizedBox(height: 20),
              const Text('Preferred Date & Time', style: AppTextStyles.label),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        DateFormat('MMM dd, yyyy').format(_selectedDate),
                      ),
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().add(
                            const Duration(days: 1),
                          ),
                          lastDate: DateTime.now().add(
                            const Duration(days: 90),
                          ),
                          initialDate: _selectedDate,
                        );
                        if (d != null) setState(() => _selectedDate = d);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(_selectedTime.format(context)),
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (t != null) setState(() => _selectedTime = t);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _purposeController,
                decoration: const InputDecoration(
                  labelText: 'Purpose of Visit',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes for Doctor (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Send Request',
                isLoading: actionState.isLoading,
                onPressed: () {
                  if (!_formKey.currentState!.validate() ||
                      _selectedDoctor == null)
                    return;
                  final dt = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );
                  ref
                      .read(appointmentActionsProvider.notifier)
                      .requestAppointment({
                        'doctor_id': _selectedDoctor!.id,
                        'appointment_date': dt.toIso8601String(),
                        'purpose': _purposeController.text,
                        'notes': _notesController.text,
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
