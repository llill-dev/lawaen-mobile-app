import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OfferContactInfoStep extends StatefulWidget {
  const OfferContactInfoStep({super.key});

  @override
  State<OfferContactInfoStep> createState() => _OfferContactInfoStepState();
}

class _OfferContactInfoStepState extends State<OfferContactInfoStep> {
  late final TextEditingController _phoneController;
  late final TextEditingController _whatsappController;

  @override
  void initState() {
    super.initState();
    final contact = context.read<AddOfferFormCubit>().state.params.contact;
    _phoneController = TextEditingController(text: contact.phone ?? '');
    _whatsappController = TextEditingController(text: contact.whatsapp ?? '');

    final cubit = context.read<AddOfferFormCubit>();
    _phoneController.addListener(() => cubit.updatePhone(_phoneController.text));
    _whatsappController.addListener(() => cubit.updateWhatsapp(_whatsappController.text));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _whatsappController.dispose();
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
      ],
    );
  }
}
