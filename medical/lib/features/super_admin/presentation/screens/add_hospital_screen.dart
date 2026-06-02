import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../sharedwidgets/custom_button.dart';
import '../providers/hospitals_provider.dart';

class AddHospitalScreen extends ConsumerStatefulWidget {
  const AddHospitalScreen({super.key});
  @override ConsumerState<AddHospitalScreen> createState() => _AddHospitalScreenState();
}

class _AddHospitalScreenState extends ConsumerState<AddHospitalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(hospitalActionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Hospital')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Center(
              child: CircleAvatar(radius: 40, backgroundColor: Colors.grey, child: Icon(Icons.camera_alt, color: Colors.white)),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Hospital Name', border: OutlineInputBorder()),
              validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _address,
              decoration: const InputDecoration(labelText: 'Physical Address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Contact Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Onboard Hospital',
              isLoading: actionState.isLoading,
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                await ref.read(hospitalActionsProvider.notifier).addHospital(
                  name: _name.text, address: _address.text, email: _email.text,
                );
                if (mounted) context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}