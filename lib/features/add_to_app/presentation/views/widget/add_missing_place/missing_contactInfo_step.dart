import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MissingContactInfoStep extends StatefulWidget {
  const MissingContactInfoStep({super.key});

  @override
  State<MissingContactInfoStep> createState() => _MissingContactInfoStepState();
}

class _MissingContactInfoStepState extends State<MissingContactInfoStep> {
  late final TextEditingController _phoneController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _instagramController;
  late final TextEditingController _facebookController;

  @override
  void initState() {
    super.initState();
    final contact = context.read<AddMissingPlaceFormCubit>().state.params.contact;
    _phoneController = TextEditingController(text: contact.phone ?? '');
    _whatsappController = TextEditingController(text: contact.whatsapp ?? '');
    _instagramController = TextEditingController(text: contact.instagram ?? '');
    _facebookController = TextEditingController(text: contact.facebook ?? '');

    final cubit = context.read<AddMissingPlaceFormCubit>();
    _phoneController.addListener(() => cubit.updatePhone(_phoneController.text));
    _whatsappController.addListener(() => cubit.updateWhatsapp(_whatsappController.text));
    _instagramController.addListener(() => cubit.updateInstagram(_instagramController.text));
    _facebookController.addListener(() => cubit.updateFacebook(_facebookController.text));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _whatsappController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFiledItem(
          title: LocaleKeys.phoneNumber.tr(),
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        TextFiledItem(
          title: LocaleKeys.whatsappNumber.tr(),
          controller: _whatsappController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.instagramPageLink.tr(), controller: _instagramController),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.facebookPageLink.tr(), controller: _facebookController),
      ],
    );
  }
}
