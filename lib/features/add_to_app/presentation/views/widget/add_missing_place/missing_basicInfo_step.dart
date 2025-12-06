import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MissingBasicInfoStep extends StatefulWidget {
  const MissingBasicInfoStep({super.key});

  @override
  State<MissingBasicInfoStep> createState() => _MissingBasicInfoStepState();
}

class _MissingBasicInfoStepState extends State<MissingBasicInfoStep> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final params = context.read<AddMissingPlaceFormCubit>().state.params;
    _nameController = TextEditingController(text: params.name ?? '');
    _descriptionController = TextEditingController(text: params.description ?? '');

    final cubit = context.read<AddMissingPlaceFormCubit>();
    _nameController.addListener(() => cubit.updateName(_nameController.text));
    _descriptionController.addListener(() => cubit.updateDescription(_descriptionController.text));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMissingPlaceFormCubit>();

    return Column(
      children: [
        NoteContainer(note: LocaleKeys.addMissingPlaceNote.tr()),
        const SizedBox(height: 12),
        DropDownItem(
          title: LocaleKeys.selectMainCategory.tr(),
          items: ["Category 1", "Category 2"],
          onChanged: cubit.updateMainCategory,
        ),
        const SizedBox(height: 12),
        DropDownItem(
          title: LocaleKeys.selectSubCategory.tr(),
          items: ["Sub 1", "Sub 2"],
          onChanged: cubit.updateSubCategory,
        ),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.name.tr(), controller: _nameController),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, controller: _descriptionController),
      ],
    );
  }
}
