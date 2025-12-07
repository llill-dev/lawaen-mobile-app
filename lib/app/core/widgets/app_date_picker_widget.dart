import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';

class AppDatePickerField extends StatelessWidget {
  final String title;
  final String? value;
  final String? hint;
  final void Function(DateTime date) onDateSelected;

  const AppDatePickerField({super.key, required this.title, required this.onDateSelected, this.value, this.hint});

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: title,
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
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayText = value ?? "";

    return GestureDetector(
      onTap: () => _pickDate(context),
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
