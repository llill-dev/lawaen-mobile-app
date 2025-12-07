import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventBookingDetailsStep extends StatefulWidget {
  const EventBookingDetailsStep({super.key});

  @override
  State<EventBookingDetailsStep> createState() => _EventBookingDetailsStepState();
}

class _EventBookingDetailsStepState extends State<EventBookingDetailsStep> {
  late final TextEditingController _priceController;
  late final TextEditingController _organiserLinkController;
  late final TextEditingController _bookingMethodController;

  @override
  void initState() {
    super.initState();
    final params = context.read<AddEventFormCubit>().state.params;
    _priceController = TextEditingController(text: params.price ?? '');
    _organiserLinkController = TextEditingController(text: params.organization ?? '');
    _bookingMethodController = TextEditingController(text: params.bookingMethod ?? '');

    final cubit = context.read<AddEventFormCubit>();
    _priceController.addListener(() => cubit.updatePrice(_priceController.text));
    _organiserLinkController.addListener(() => cubit.updateOrganization(_organiserLinkController.text));
    _bookingMethodController.addListener(() => cubit.updateBookingMethod(_bookingMethodController.text));
  }

  @override
  void dispose() {
    _priceController.dispose();
    _organiserLinkController.dispose();
    _bookingMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        return Column(
          children: [
            16.verticalSpace,
            TextFiledItem(title: LocaleKeys.bookingMethod.tr(), controller: _bookingMethodController),
            12.verticalSpace,
            TextFiledItem(
              title: LocaleKeys.price.tr(),
              keyboardType: TextInputType.number,
              controller: _priceController,
            ),
            12.verticalSpace,
            TextFiledItem(title: LocaleKeys.organizerPageLink.tr(), controller: _organiserLinkController),
          ],
        );
      },
    );
  }
}
