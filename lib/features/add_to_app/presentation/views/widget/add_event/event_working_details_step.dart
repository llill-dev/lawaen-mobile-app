import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/app_date_picker_widget.dart';
import 'package:lawaen/app/core/widgets/app_time_picker_field.dart';
import 'package:lawaen/features/add_to_app/presentation/cubit/add_event_cubit/add_event_form_cubit.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/text_filed_item.dart';
import 'package:lawaen/features/add_to_app/presentation/views/widget/we_dont_collect_data_text.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class EventWorkingDetailsStep extends StatefulWidget {
  const EventWorkingDetailsStep({super.key});

  @override
  State<EventWorkingDetailsStep> createState() => _EventWorkingDetailsStepState();
}

class _EventWorkingDetailsStepState extends State<EventWorkingDetailsStep> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    final params = context.read<AddEventFormCubit>().state.params;

    _noteController = TextEditingController(text: params.note ?? '');

    _noteController.addListener(() {
      context.read<AddEventFormCubit>().updateNote(_noteController.text);
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventFormCubit, AddEventFormState>(
      builder: (context, state) {
        final cubit = context.read<AddEventFormCubit>();
        final params = state.params;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTimePickerField(
                      title: LocaleKeys.startTime.tr(),
                      value: params.startTime,
                      hint: "00:00",
                      onTimeSelected: (t) {
                        final formatted = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
                        cubit.updateStartTime(formatted);
                      },
                    ),
                  ),
                  Expanded(
                    child: AppTimePickerField(
                      title: LocaleKeys.endTime.tr(),
                      value: params.endTime,
                      hint: "00:00",
                      onTimeSelected: (t) {
                        final formatted = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
                        cubit.updateEndTime(formatted);
                      },
                    ),
                  ),
                ],
              ),

              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppDatePickerField(
                      title: LocaleKeys.startEventDate.tr(),
                      value: params.startEventDate,
                      hint: "dd/mm/yyyy",
                      onDateSelected: (d) {
                        final formatted =
                            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
                        cubit.updateStartEventDate(formatted);
                      },
                    ),
                  ),
                  Expanded(
                    child: AppDatePickerField(
                      title: LocaleKeys.endEventDate.tr(),
                      value: params.endEventDate,
                      hint: "dd/mm/yyyy",
                      onDateSelected: (d) {
                        final formatted =
                            "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
                        cubit.updateEndEventDate(formatted);
                      },
                    ),
                  ),
                ],
              ),

              16.verticalSpace,
              AppDatePickerField(
                title: LocaleKeys.eventTime.tr(),
                value: params.eventTime,
                hint: "dd/mm/yyyy",
                onDateSelected: (d) {
                  final formatted =
                      "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
                  cubit.updateEventTime(formatted);
                },
              ),

              16.verticalSpace,
              TextFiledItem(title: LocaleKeys.note.tr(), maxLines: 4, controller: _noteController),

              24.verticalSpace,
              const WeDontCollectDataText(),
            ],
          ),
        );
      },
    );
  }
}
