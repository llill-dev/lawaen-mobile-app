import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OfferBasicInfoStep extends StatelessWidget {
  const OfferBasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddOfferFormCubit>();

    return Column(
      children: [
        NoteContainer(note: LocaleKeys.addClassifiedNote.tr()),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.fullName.tr(), onChanged: cubit.updateName),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, onChanged: cubit.updateDescription),
      ],
    );
  }
}
