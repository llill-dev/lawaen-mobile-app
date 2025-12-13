import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/drop_down_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:lawaen/features/profile/presentation/params/contact_us_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final TextEditingController _messageController = TextEditingController();
  String? _selectedTypeKey;

  static const List<String> _contactTypeKeys = [
    LocaleKeys.contactUsTypeInfo,
    LocaleKeys.contactUsTypeHelp,
    LocaleKeys.contactUsTypeSuggestion,
    LocaleKeys.contactUsTypeComplaint,
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_selectedTypeKey == null) {
      showToast(message: LocaleKeys.contactUsTypeRequired.tr(), isError: true);
      return;
    }

    final message = _messageController.text.trim();
    if (message.isEmpty) {
      showToast(message: LocaleKeys.contactUsMessageRequired.tr(), isError: true);
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<ProfileCubit>().contactUs(ContactUsParams(type: _selectedTypeKey!.tr(), message: message));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.contactUsState == RequestState.success) {
          showToast(message: LocaleKeys.contactUsSendSuccess.tr(), isSuccess: true);
          setState(() {
            _selectedTypeKey = null;
            _messageController.clear();
          });
        } else if (state.contactUsState == RequestState.error) {
          showToast(message: state.contactUsError ?? LocaleKeys.defaultError.tr(), isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state.contactUsState == RequestState.loading;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              DropDownItem(
                title: LocaleKeys.contactUsMessageType.tr(),
                items: _contactTypeKeys,
                hit: LocaleKeys.contactUsChooseType.tr(),
                initialValue: _selectedTypeKey,
                itemLabelBuilder: (value) => value.tr(),
                onChanged: (value) {
                  setState(() {
                    _selectedTypeKey = value;
                  });
                },
              ),
              16.verticalSpace,
              TextFiledItem(
                title: LocaleKeys.contactUsMessageLabel.tr(),
                hintText: LocaleKeys.contactUsMessageHint.tr(),
                maxLines: 4,
                controller: _messageController,
              ),
              16.verticalSpace,
              PrimaryButton(
                text: LocaleKeys.contactUsSendButton.tr(),
                isLoading: isLoading,
                onPressed: isLoading ? null : () => _submit(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
