import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../sharedwidgets/custom_button.dart';
import '../../providers/doctor_providers.dart';
import 'steps/info_step.dart';
import 'steps/meds_step.dart';
import 'steps/advice_step.dart';
import 'steps/review_step.dart';

class CreatePrescriptionScreen extends ConsumerStatefulWidget {
  final int patientId;
  const CreatePrescriptionScreen({super.key, required this.patientId});

  @override
  ConsumerState<CreatePrescriptionScreen> createState() =>
      _CreatePrescriptionScreenState();
}

class _CreatePrescriptionScreenState
    extends ConsumerState<CreatePrescriptionScreen> {
  int _currentStep = 0;

  // Form Data
  final _infoFormKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  List<Map<String, dynamic>> _selectedMeds = [];
  List<Map<String, dynamic>> _advice = [];

  @override
  void dispose() {
    _diagnosisController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onStepContinue() {
    if (_currentStep == 0 && !_infoFormKey.currentState!.validate()) return;
    if (_currentStep == 1 && _selectedMeds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one medication')),
      );
      return;
    }

    if (_currentStep < 3) {
      setState(() => _currentStep += 1);
    } else {
      _submitPrescription();
    }
  }

  Future<void> _submitPrescription() async {
    final data = {
      'patient_id': widget.patientId,
      'diagnosis': _diagnosisController.text,
      'notes': _notesController.text,
      'start_date': _startDate.toIso8601String().split('T')[0],
      'end_date': _endDate?.toIso8601String().split('T')[0],
      'medications': _selectedMeds,
      'lifestyle_advice': _advice,
    };

    await ref
        .read(prescriptionActionsProvider.notifier)
        .createPrescription(data);

    if (mounted && !ref.read(prescriptionActionsProvider).hasError) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(prescriptionActionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Prescription'),
        backgroundColor: AppColors.background,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (step) {
          if (step < _currentStep) setState(() => _currentStep = step);
        },
        onStepContinue: _onStepContinue,
        onStepCancel:
            _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
        controlsBuilder: (context, controls) {
          return Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: _currentStep == 3 ? 'Confirm & Issue' : 'Continue',
                    isLoading: actionState.isLoading,
                    onPressed: controls.onStepContinue,
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Back',
                      variant: ButtonVariant.outlined,
                      onPressed: controls.onStepCancel,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Info'),
            isActive: _currentStep >= 0,
            content: InfoStep(
              formKey: _infoFormKey,
              diagnosisController: _diagnosisController,
              notesController: _notesController,
              startDate: _startDate,
              endDate: _endDate,
              onDateChanged:
                  (start, end) => setState(() {
                    _startDate = start;
                    _endDate = end;
                  }),
            ),
          ),
          Step(
            title: const Text('Meds'),
            isActive: _currentStep >= 1,
            content: MedsStep(
              meds: _selectedMeds,
              onUpdate: (val) => setState(() => _selectedMeds = val),
            ),
          ),
          Step(
            title: const Text('Advice'),
            isActive: _currentStep >= 2,
            content: AdviceStep(
              advice: _advice,
              onUpdate: (val) => setState(() => _advice = val),
            ),
          ),
          Step(
            title: const Text('Review'),
            isActive: _currentStep >= 3,
            content: ReviewStep(
              diagnosis: _diagnosisController.text,
              meds: _selectedMeds,
              advice: _advice,
            ),
          ),
        ],
      ),
    );
  }
}
