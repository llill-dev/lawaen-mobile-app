import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/note_container.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OfferBasicInfoStep extends StatefulWidget {
  const OfferBasicInfoStep({super.key});

  @override
  State<OfferBasicInfoStep> createState() => _OfferBasicInfoStepState();
}

class _OfferBasicInfoStepState extends State<OfferBasicInfoStep> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final params = context.read<AddOfferFormCubit>().state.params;
    _nameController = TextEditingController(text: params.name ?? '');
    _descriptionController = TextEditingController(text: params.description ?? '');

    final cubit = context.read<AddOfferFormCubit>();
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
    return Column(
      children: [
        NoteContainer(note: LocaleKeys.addClassifiedNote.tr()),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.fullName.tr(), controller: _nameController),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.description.tr(), maxLines: 4, controller: _descriptionController),
      ],
    );
  }
}
