import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventContactInfoStep extends StatelessWidget {
  const EventContactInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 24.h),
      child: BlocBuilder<AddEventFormCubit, AddEventFormState>(
        builder: (context, state) {
          final cubit = context.read<AddEventFormCubit>();

          return Column(
            children: [
              16.verticalSpace,
              TextFiledItem(title: LocaleKeys.phoneNumberWithCode.tr(), onChanged: cubit.updatePhone),
              12.verticalSpace,
              TextFiledItem(title: LocaleKeys.whatsappNumber.tr(), onChanged: cubit.updateWhatsapp),
              12.verticalSpace,
              TextFiledItem(title: LocaleKeys.instagramPageLink.tr(), onChanged: cubit.updateInstagram),
              12.verticalSpace,
              TextFiledItem(title: LocaleKeys.facebookPageLink.tr(), onChanged: cubit.updateFacebook),
            ],
          );
        },
      ),
    );
  }
}
