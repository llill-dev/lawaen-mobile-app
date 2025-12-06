import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventContactInfoStep extends StatefulWidget {
  const EventContactInfoStep({super.key});

  @override
  State<EventContactInfoStep> createState() => _EventContactInfoStepState();
}

class _EventContactInfoStepState extends State<EventContactInfoStep> {
  late final TextEditingController _phoneController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _instagramController;
  late final TextEditingController _facebookController;

  @override
  void initState() {
    super.initState();
    final contact = context.read<AddEventFormCubit>().state.params.contact;

    _phoneController = TextEditingController(text: contact.phone ?? '');
    _whatsappController = TextEditingController(text: contact.whatsapp ?? '');
    _instagramController = TextEditingController(text: contact.instagram ?? '');
    _facebookController = TextEditingController(text: contact.facebook ?? '');

    final cubit = context.read<AddEventFormCubit>();
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
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 24.h),
      child: BlocBuilder<AddEventFormCubit, AddEventFormState>(
        builder: (context, state) {
          return Column(
            children: [
              16.verticalSpace,
              TextFiledItem(
                title: LocaleKeys.phoneNumberWithCode.tr(),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              12.verticalSpace,
              TextFiledItem(
                title: LocaleKeys.whatsappNumber.tr(),
                controller: _whatsappController,
                keyboardType: TextInputType.phone,
              ),
              12.verticalSpace,
              TextFiledItem(title: LocaleKeys.instagramPageLink.tr(), controller: _instagramController),
              12.verticalSpace,
              TextFiledItem(title: LocaleKeys.facebookPageLink.tr(), controller: _facebookController),
            ],
          );
        },
      ),
    );
  }
}
