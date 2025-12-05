import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MissingBasicInfoStep extends StatelessWidget {
  const MissingBasicInfoStep({super.key});

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
        TextFiledItem(title: LocaleKeys.name.tr(), onChanged: cubit.updateName),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, onChanged: cubit.updateDescription),
      ],
    );
  }
}
