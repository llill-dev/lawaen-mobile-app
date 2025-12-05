import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventBookingDetailsStep extends StatelessWidget {
  const EventBookingDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingMethods = <String>[
      LocaleKeys.bookingMethodOnline.tr(),
      LocaleKeys.bookingMethodOnSite.tr(),
      // add more if you have
    ];

    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        final cubit = context.read<AddEventFormCubit>();

        return Column(
          children: [
            16.verticalSpace,
            DropDownItem(
              title: LocaleKeys.bookingMethod.tr(),
              items: bookingMethods,
              onChanged: cubit.updateBookingMethod,
            ),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.price.tr(), onChanged: cubit.updatePrice),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.organizerPageLink.tr(), onChanged: cubit.updateOrganiserLink),
          ],
        );
      },
    );
  }
}
