import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventBasicInfoStpe extends StatelessWidget {
  const EventBasicInfoStpe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        final cubit = context.read<AddEventFormCubit>();

        return Column(
          children: [
            NoteContainer(note: LocaleKeys.addEventNote.tr()),
            16.verticalSpace,
            DropDownItem(title: LocaleKeys.eventType.tr(), items: []),
            12.verticalSpace,
            TextFiledItem(
              title: LocaleKeys.fullName.tr(),
              hintText: LocaleKeys.fullName.tr(),
              onChanged: cubit.updateName,
            ),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, onChanged: cubit.updateDescription),
          ],
        );
      },
    );
  }
}
