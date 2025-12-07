import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';

class AppTimePickerField extends StatelessWidget {
  final String title;
  final String? value;
  final String? hint;
  final void Function(TimeOfDay time) onTimeSelected;

  const AppTimePickerField({super.key, required this.title, required this.onTimeSelected, this.value, this.hint});

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorManager.primary,
              onPrimary: ColorManager.white,
              onSurface: ColorManager.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayText = value ?? "";

    return GestureDetector(
      onTap: () => _pickTime(context),
      child: AbsorbPointer(
        child: TextFiledItem(
          title: title,
          hintText: hint,
          readOnly: true,
          controller: TextEditingController(text: displayText),
        ),
      ),
    );
  }
}
