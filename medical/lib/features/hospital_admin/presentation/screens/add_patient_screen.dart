import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/hospital_provider.dart';

class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key});
  @override ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final _name = TextEditingController(); final _email = TextEditingController(); final _diagnosis = TextEditingController();

  @override Widget build(BuildContext context) {
    final actionState = ref.watch(hospitalActionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Patient')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 16),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email Address')),
            const SizedBox(height: 16),
            TextField(controller: _diagnosis, decoration: const InputDecoration(labelText: 'Primary Diagnosis')),
            const Spacer(),
            CustomButton(text: 'Create Account', isLoading: actionState.isLoading, onPressed: () => ref.read(hospitalActionsProvider.notifier).addUser({'full_name': _name.text, 'email': _email.text, 'role': 'patient', 'diagnosis': _diagnosis.text}).then((_) => context.pop())),
          ],
        ),
      ),
    );
  }
}