import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_offer_cubit/add_offer_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OfferContactInfoStep extends StatelessWidget {
  const OfferContactInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddOfferFormCubit>();

    return Column(
      children: [
        TextFiledItem(title: LocaleKeys.phoneNumber.tr(), onChanged: cubit.updatePhone),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.whatsappNumber.tr(), onChanged: cubit.updateWhatsapp),
      ],
    );
  }
}
