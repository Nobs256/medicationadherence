import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../doctor/presentation/providers/doctor_providers.dart';
import '../providers/appointment_provider.dart';
import '../../../auth/domain/models/user_profile.dart';
import 'package:go_router/go_router.dart';

class ScheduleAppointmentScreen extends ConsumerStatefulWidget {
  const ScheduleAppointmentScreen({super.key});

  @override
  ConsumerState<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState
    extends ConsumerState<ScheduleAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  UserProfile? _selectedPatient;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  final _purposeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(myPatientsProvider);
    final actionState = ref.watch(appointmentActionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Schedule Appointment'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Patient', style: AppTextStyles.label),
              const SizedBox(height: 8),
              patientsAsync.when(
                data:
                    (patients) => DropdownButtonFormField<UserProfile>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Patient',
                      ),
                      items:
                          patients
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p.fullName),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (val) => setState(() => _selectedPatient = val),
                      validator: (v) => v == null ? 'Required' : null,
                    ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Error loading patients'),
              ),
              const SizedBox(height: 20),
              const Text('Date & Time', style: AppTextStyles.label),
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
                          firstDate: DateTime.now(),
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
                  labelText: 'Internal Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Schedule Appointment',
                isLoading: actionState.isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate() ||
                      _selectedPatient == null)
                    return;
                  final dt = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );
                  await ref
                      .read(appointmentActionsProvider.notifier)
                      .scheduleAppointment({
                        'patient_id': _selectedPatient!.id,
                        'appointment_date': dt.toIso8601String(),
                        'purpose': _purposeController.text,
                        'notes': _notesController.text,
                      });
                  if (mounted) context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
