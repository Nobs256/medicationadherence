import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';
import '../../../../../../sharedwidgets/custom_button.dart';

class AdviceStep extends StatelessWidget {
  final List<Map<String, dynamic>> advice;
  final Function(List<Map<String, dynamic>>) onUpdate;

  const AdviceStep({super.key, required this.advice, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Lifestyle Advice', style: AppTextStyles.h3),
            TextButton.icon(
              onPressed: () => _showAddAdviceSheet(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Advice'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (advice.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'Optional: Add diet or exercise tips.',
                style: AppTextStyles.bodySm,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: advice.length,
            itemBuilder: (context, index) {
              final item = advice[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(
                      _getIcon(item['type']),
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item['title'],
                    style: AppTextStyles.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    item['description'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    onPressed: () {
                      final newList = List<Map<String, dynamic>>.from(advice);
                      newList.removeAt(index);
                      onUpdate(newList);
                    },
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'exercise':
        return Icons.directions_run;
      case 'diet':
        return Icons.restaurant;
      case 'hydration':
        return Icons.water_drop;
      case 'sleep':
        return Icons.bedtime;
      default:
        return Icons.lightbulb_outline;
    }
  }

  void _showAddAdviceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) =>
              _AddAdviceForm(onAdd: (item) => onUpdate([...advice, item])),
    );
  }
}

class _AddAdviceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;
  const _AddAdviceForm({required this.onAdd});

  @override
  State<_AddAdviceForm> createState() => _AddAdviceFormState();
}

class _AddAdviceFormState extends State<_AddAdviceForm> {
  String _type = 'general';
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('New Advice', style: AppTextStyles.h2),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _type,
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items:
                ['general', 'exercise', 'diet', 'hydration', 'sleep']
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.toUpperCase()),
                      ),
                    )
                    .toList(),
            onChanged: (val) => setState(() => _type = val!),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Instructions',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Add Advice',
            onPressed: () {
              if (_titleController.text.isEmpty) return;
              widget.onAdd({
                'type': _type,
                'title': _titleController.text,
                'description': _descController.text,
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
