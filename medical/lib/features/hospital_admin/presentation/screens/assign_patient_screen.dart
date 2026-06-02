import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../../../auth/domain/models/user_profile.dart';
import '../providers/hospital_provider.dart';

class AssignPatientScreen extends ConsumerStatefulWidget {
  final int patientId;
  const AssignPatientScreen({super.key, required this.patientId});
  @override ConsumerState<AssignPatientScreen> createState() => _AssignPatientScreenState();
}

class _AssignPatientScreenState extends ConsumerState<AssignPatientScreen> {
  UserProfile? _selectedDoctor;

  @override
  Widget build(BuildContext context) {
    final doctorsAsync = ref.watch(hospitalDoctorsProvider);
    final actionState = ref.watch(hospitalActionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Assign Doctor'), backgroundColor: AppColors.background),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Doctor', style: AppTextStyles.label),
            const SizedBox(height: 12),
            doctorsAsync.when(
              data: (doctors) => DropdownButtonFormField<UserProfile>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: doctors.map((d) => DropdownMenuItem(value: d, child: Text(d.fullName))).toList(),
                onChanged: (v) => setState(() => _selectedDoctor = v),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, __) => Text('Error: $e'),
            ),
            const Spacer(),
            CustomButton(
              text: 'Confirm Assignment',
              isLoading: actionState.isLoading,
              onPressed: _selectedDoctor == null ? null : () => ref.read(hospitalActionsProvider.notifier).assignPatient(widget.patientId, _selectedDoctor!.id).then((_) => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}