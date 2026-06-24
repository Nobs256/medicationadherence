import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/hospital_provider.dart';

class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key});
  @override
  ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _diagnosis = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _diagnosis.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(hospitalActionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Patient')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator:
                    (v) =>
                        v == null || v.trim().isEmpty
                            ? 'Full name is required'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _diagnosis,
                decoration: const InputDecoration(
                  labelText: 'Primary Diagnosis',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_hospital_outlined),
                ),
                validator:
                    (v) =>
                        v == null || v.trim().isEmpty
                            ? 'Diagnosis is required'
                            : null,
              ),
              const Spacer(),
              CustomButton(
                text: 'Create Account',
                isLoading: actionState.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final result = await ref
                        .read(hospitalActionsProvider.notifier)
                        .addUser({
                          'full_name': _name.text.trim(),
                          'email': _email.text.trim(),
                          'role': 'patient',
                          'diagnosis': _diagnosis.text.trim(),
                          'password': '123456',
                        });

                    if (mounted && result != null) {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (dialogContext) => AlertDialog(
                              title: const Text('Account Created'),
                              content: SelectableText(
                                'An account for ${_name.text.trim()} has been created.\n\n'
                                'Temporary Password: ${result['temporary_password']}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(dialogContext).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                      if (mounted) {
                        context.pop();
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
