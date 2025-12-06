import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventBasicInfoStpe extends StatefulWidget {
  const EventBasicInfoStpe({super.key});

  @override
  State<EventBasicInfoStpe> createState() => _EventBasicInfoStpeState();
}

class _EventBasicInfoStpeState extends State<EventBasicInfoStpe> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final params = context.read<AddEventFormCubit>().state.params;
    _nameController = TextEditingController(text: params.name ?? '');
    _descriptionController = TextEditingController(text: params.description ?? '');

    final cubit = context.read<AddEventFormCubit>();
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
    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        return Column(
          children: [
            NoteContainer(note: LocaleKeys.addEventNote.tr()),
            16.verticalSpace,
            DropDownItem(title: LocaleKeys.eventType.tr(), items: []),
            12.verticalSpace,
            TextFiledItem(
              title: LocaleKeys.fullName.tr(),
              hintText: LocaleKeys.fullName.tr(),
              controller: _nameController,
            ),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, controller: _descriptionController),
          ],
        );
      },
    );
  }
}
