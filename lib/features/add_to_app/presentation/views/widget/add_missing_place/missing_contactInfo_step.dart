import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_missing_place_cubit/add_missing_place_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class MissingContactInfoStep extends StatelessWidget {
  const MissingContactInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddMissingPlaceFormCubit>();

    return Column(
      children: [
        TextFiledItem(title: LocaleKeys.phoneNumber.tr(), onChanged: cubit.updatePhone),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.whatsappNumber.tr(), onChanged: cubit.updateWhatsapp),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.instagramPageLink.tr(), onChanged: cubit.updateInstagram),
        const SizedBox(height: 12),
        TextFiledItem(title: LocaleKeys.facebookPageLink.tr(), onChanged: cubit.updateFacebook),
      ],
    );
  }
}
