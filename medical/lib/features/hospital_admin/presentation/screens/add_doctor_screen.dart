import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/hospital_provider.dart';

class AddDoctorScreen extends ConsumerStatefulWidget {
  const AddDoctorScreen({super.key});
  @override
  ConsumerState<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(hospitalActionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Doctor')),
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
                          'role': 'doctor',
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
                                'An account for Dr. ${_name.text.trim()} has been created.\n\n'
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
