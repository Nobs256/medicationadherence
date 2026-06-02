import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/hospital_provider.dart';

class AddDoctorScreen extends ConsumerStatefulWidget {
  const AddDoctorScreen({super.key});
  @override ConsumerState<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
  final _name = TextEditingController(); final _email = TextEditingController();

  @override Widget build(BuildContext context) {
    final actionState = ref.watch(hospitalActionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Doctor')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 16),
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email Address')),
            const Spacer(),
            CustomButton(text: 'Create Account', isLoading: actionState.isLoading, onPressed: () => ref.read(hospitalActionsProvider.notifier).addUser({'full_name': _name.text, 'email': _email.text, 'role': 'doctor'}).then((_) => context.pop())),
          ],
        ),
      ),
    );
  }
}